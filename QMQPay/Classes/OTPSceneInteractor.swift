//
//  OTPSceneInteractor.swift
//  QatarPaySDK
//
//  Created by Hussam Elsadany on 21/09/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol OTPSceneBusinessLogic: AnyObject {
    func processPayment(otp: String)
}

protocol OTPSceneDataStore: AnyObject {
    var configModel: ConfigModel? { get set }
    var pinCode: String? { get set }
    var initatePayment: IniatePaymentModel? { get set }
    var processPayment: ProcessPaymentModel? { get set }
}

class OTPSceneInteractor: OTPSceneBusinessLogic, OTPSceneDataStore {

    // MARK: Stored Properties
    let presenter: OTPScenePresentationLogic

    var configModel: ConfigModel? = nil

    var pinCode: String? = nil

    var initatePayment: IniatePaymentModel? = nil

    var processPayment: ProcessPaymentModel? = nil

    let worker = OTPSceneWorkers()

    // MARK: Initializers
    required init(presenter: OTPScenePresentationLogic) {
        self.presenter = presenter
    }
}

extension OTPSceneInteractor {

    func processPayment(otp: String) {
        guard let token = self.configModel?.token, let pinCode = self.pinCode, let refrenceId = self.initatePayment?.referenceID, let requestId = self.initatePayment?.requestID, let requestNumber = self.initatePayment?.requestNumber else {
            return
        }

        self.worker.proceedPayment(token: token,
                                   pinCode: pinCode,
                                   refrenceId: refrenceId,
                                   requestId: requestId,
                                   requestNumber: requestNumber,
                                   otp: otp) { response in
            self.processPayment = response
            if response.success ?? false {
                self.presenter.presentSuccessPayment()
            } else {
                self.presenter.presentError(error: response.message ?? "Something Wrong Happen.")
            }
        } failure: { error in
            self.presenter.presentError(error: error)
        }
    }
}
