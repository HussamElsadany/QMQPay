//
//  OTPSceneWorkers.swift
//  QatarPaySDK
//
//  Created by Hussam Elsadany on 21/09/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class OTPSceneWorkers {

    func proceedPayment(token: String,
                        pinCode: String,
                        refrenceId: String,
                        requestId: Int,
                        requestNumber: String,
                        otp: String,
                        success: @escaping (ProcessPaymentModel) -> Void,
                        failure: @escaping (Error) -> Void) {

        let router = ApiRequest.proceedPayment(token: token,
                                               pinCode: pinCode,
                                               refrenceId: refrenceId,
                                               requestId: requestId,
                                               requestNumber: requestNumber,
                                               otp: otp)
        NetworkManager.sendRequest(router) { (statusCode, result: Result<ProcessPaymentModel>) in
            switch result {
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
