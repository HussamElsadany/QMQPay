//
//  QatarPaySceneInteractor.swift
//  QatarPay
//
//  Created by HE on 17/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RMQClient

enum InternalErrors: Error {
    case InvalidUserNameAndPassword
}

protocol QatarPaySceneBusinessLogic: AnyObject {
    func getQRPayment()
    func initiatePayment(pinCode: String, email: String)
    func startListenToRabitMQ()
}

protocol QatarPaySceneDataStore: AnyObject {
    var config: ConfigModel? { get set }
    var paymentRequest: QRPaymentModel? { get set }
    var initatePayment: IniatePaymentModel? { get set }
}

class QatarPaySceneInteractor: QatarPaySceneBusinessLogic, QatarPaySceneDataStore {

    // MARK: Stored Properties
    let presenter: QatarPayScenePresentationLogic

    var config: ConfigModel? = nil

    var paymentRequest: QRPaymentModel? = nil

    var initatePayment: IniatePaymentModel? = nil

    var refrence: String!

    let worker = QatarPaySceneWorkers()

    // MARK: Initializers
    required init(presenter: QatarPayScenePresentationLogic) {
        self.presenter = presenter
        self.refrence = self.randomString()
    }
}

extension QatarPaySceneInteractor {

    func getQRPayment() {
        guard let token = self.config?.token, let amount = self.config?.amount, let projectId = self.config?.projectId, let merchantDefineData = self.config?.merchantDefinedData, let merchantId = self.config?.merchantId, let merchantEmail = self.config?.merchantEmail, let desc = self.config?.description, let privateKey = self.config?.privateKey, let privateKeyId = self.config?.privateKeyId else {
            return
        }

        let paramsString = "\(amount)\(desc)\(merchantDefineData)\(merchantEmail)\(refrence ?? "")\(merchantId)\(projectId)"
        let secureHash = paramsString.hmac(algorithm: .SHA256, key: privateKey)

        self.worker.getQRPayment(token: token,
                                 projectId: projectId,
                                 amount: amount,
                                 merchantId: merchantId,
                                 merchantDefineData: merchantDefineData,
                                 merchantRefrence: self.refrence,
                                 merchantEmail: merchantEmail,
                                 description: desc,
                                 privateKey: privateKey,
                                 privateKeyId: privateKeyId,
                                 secureHash: secureHash) { response in
            self.paymentRequest = response
            self.presenter.present(qrData: response, configModel: self.config!)
            self.startListenToRabitMQ()
        } failure: { error in
            self.presenter.present(error: error)
        }
    }

    func initiatePayment(pinCode: String, email: String) {
        guard let token = self.config?.token, let session = self.paymentRequest?.sessionID, let uuid = self.paymentRequest?.uuid else {
            self.presenter.present(error: "Something Wrong Happen.")
            return
        }

        self.worker.initatePayment(token: token,
                                   pinCode: pinCode,
                                   email: email,
                                   sessionId: session,
                                   uuid: uuid) { response in
            self.initatePayment = response
            if response.success ?? false {
                self.presenter.presentOTP()
            } else {
                self.presenter.present(error: response.message ?? "Something Wrong Happen.")
            }
        } failure: { error in
            self.presenter.present(error: error)
        }
    }

    func startListenToRabitMQ() {

        let delegate = RMQConnectionDelegateLogger()
        let connection = RMQConnection(uri: self.getRabbitMQUrl(), delegate: delegate)
        connection.start()

        let queueName = UUID().uuidString
        let exchangeName = "qatarpay"

        let channel = connection.createChannel()
        let x = channel.fanout(exchangeName)
        let queue = channel.queue(queueName, options: .exclusive)
        queue.bind(x)
        queue.subscribe({(_ message: RMQMessage) -> Void in
            do {
                let response: ProcessPaymentModel = try JSONDecoder().decode(ProcessPaymentModel.self, from: message.body)
                if response.transactionStatus ?? false {
                    self.presenter.presentSuccessPayment(processPayment: response)
                } else {
                    self.presenter.present(error: "Payment Failed")
                }
            } catch let error {
                self.presenter.present(error: error.localizedDescription)
            }
        })
    }
}

private extension QatarPaySceneInteractor {

    func getRabbitMQUrl() -> String {
        var components = URLComponents()
        components.scheme = "amqp"
        components.host = "146.0.247.101"
        components.user = "guest"
        components.password = "guest"
        components.port = 5672
        let url = components.url?.absoluteString ?? "-"
        print("RabbitMQ URL", url)
        return url
    }

    func randomString() -> String {
        let letters = "0123456789"
        let random = String((0..<10).map{ _ in letters.randomElement()! })
        return "RE\(random)"
    }
}
