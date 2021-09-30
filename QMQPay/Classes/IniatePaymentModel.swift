//
//  IniatePaymentModel.swift
//  QatarPaySDK
//
//  Created by Hussam Elsadany on 21/09/2021.
//

public struct IniatePaymentModel: Codable {
    let referenceID: String?
    let requestID: Int?
    let requestNumber: String?
    let success: Bool?
    let code, message: String?
    let errors: [String]?

    enum CodingKeys: String, CodingKey {
        case referenceID = "ReferenceID"
        case requestID = "RequestID"
        case requestNumber = "RequestNumber"
        case success, code, message, errors
    }
}
