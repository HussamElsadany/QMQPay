//
//  QatarPaySceneWorkers.swift
//  QatarPay
//
//  Created by HE on 17/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class QatarPaySceneWorkers {

    func getToken(userName: String,
                  password: String,
                  success: @escaping (TokenModel) -> Void,
                  failure: @escaping (Error) -> Void) {
        let router = ApiRequest.getToken(username: userName, password: password)
        NetworkManager.sendRequest(router) { (statusCode, result: Result<TokenModel>) in
            switch result {
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }

    func getQRPayment(token: String,
                      projectId: String,
                      amount: Double,
                      merchantId: String,
                      merchantDefineData: String,
                      merchantRefrence: String,
                      merchantEmail: String,
                      description: String,
                      privateKey: String,
                      privateKeyId: String,
                      secureHash: String,
                      success: @escaping (QRPaymentModel) -> Void,
                      failure: @escaping (Error) -> Void) {

        let router = ApiRequest.getQrCodePaymentRequest(token: token,
                                                        projectId: projectId,
                                                        amount: amount,
                                                        merchantId: merchantId,
                                                        merchantDefineData: merchantDefineData,
                                                        merchantRefrence: merchantRefrence,
                                                        merchantEmail: merchantEmail,
                                                        description: description,
                                                        privateKey: privateKey,
                                                        privateKeyId: privateKeyId,
                                                        secureHash: secureHash)
        NetworkManager.sendRequest(router) { (statusCode, result: Result<QRPaymentModel>) in
            switch result {
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }

    func initatePayment(token: String,
                        pinCode: String,
                        email: String,
                        sessionId: String,
                        uuid: String,
                        success: @escaping (IniatePaymentModel) -> Void,
                        failure: @escaping (Error) -> Void) {

        let router = ApiRequest.initiatePayment(token: token,
                                                pinCode: pinCode,
                                                email: email,
                                                sessionId: sessionId,
                                                uuid: uuid)

        NetworkManager.sendRequest(router) { (statusCode, result: Result<IniatePaymentModel>) in
            switch result {
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
