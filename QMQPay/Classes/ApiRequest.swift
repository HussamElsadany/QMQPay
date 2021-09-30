//
//  ApiRequest.swift
//  NooqodyPay
//
//  Created by HE on 17/07/2021.
//

import Foundation

enum ApiRequest {
    case getToken(username: String, password: String)
    case getQrCodePaymentRequest(token: String, projectId: String, amount: Double, merchantId: String, merchantDefineData: String, merchantRefrence: String, merchantEmail: String, description: String, privateKey: String, privateKeyId: String, secureHash: String)
    case initiatePayment(token: String, pinCode: String, email: String, sessionId: String, uuid: String)
    case proceedPayment(token: String, pinCode: String, refrenceId: String, requestId: Int, requestNumber: String, otp: String)
}

extension ApiRequest: EndPointType {

    var parameters: Parameters? {
        switch self {
        case .getToken(let username, let password):
            return ["username": username,
                    "password": password,
                    "grant_type": "password"]
        case .getQrCodePaymentRequest(_, let projectId, let amount, let merchantId, let merchantDefineData, let merchantRefrence, let merchantEmail, let description, let privateKey, let privateKeyId, let secureHash):
            return ["project_id": projectId,
                    "amount": "\(amount)",
                    "merchant_id": merchantId,
                    "merchant_defined_data": merchantDefineData,
                    "merchant_reference": merchantRefrence,
                    "merchant_email": merchantEmail,
                    "private_key": privateKey,
                    "private_key_id": privateKeyId,
                    "description": description,
                    "secure_hash": secureHash]
        case .initiatePayment(_, let pinCode, let email, let sessionId, let uuid):
            return ["PinCode": pinCode,
                    "Email": email,
                    "SessionID": sessionId,
                    "UUID": uuid]
        case .proceedPayment(_, let pinCode, let refrenceId, let requestId, let requestNumber, let otp):
            return ["PinCode": pinCode,
                    "ReferenceID": refrenceId,
                    "RequestID": requestId,
                    "RequestNumber": requestNumber,
                    "OTP": otp]
        }
    }

    var path: ServerPaths {
        switch self {
        case .getToken:
            return .getToken
        case .getQrCodePaymentRequest:
            return .getQrCodePayment
        case .initiatePayment:
            return .initaitePayment
        case .proceedPayment:
            return .proceedPayment
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getToken:
            return .get
        case .getQrCodePaymentRequest, .initiatePayment, .proceedPayment:
            return .post
        }
    }

    var task: HTTPTask {
        switch self {
        case .getToken:
            return .requestParametersAndHeaders(bodyParameters: parameters, bodyEncoding: .formBodyUrlencoded, urlParameters: nil, additionHeaders: headers)
        case .getQrCodePaymentRequest, .initiatePayment, .proceedPayment:
            return .requestParametersAndHeaders(bodyParameters: parameters, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
        }
    }

    var headers: HTTPHeaders? {
        switch self {
        case .getQrCodePaymentRequest(let token, _, _, _, _, _, _, _, _, _, _), .initiatePayment(let token, _, _, _, _), .proceedPayment(let token, _, _, _, _, _):
            return ["Authorization": "bearer \(token)"]
        default:
            return nil
        }
    }

    var pathArgs: [String]? {
        return nil
    }
}
