//
//  PaymentLinksModel.swift
//  NooqodyPay
//
//  Created by HE on 17/07/2021.
//

struct QRPaymentModel: Codable {
    let qrCodeData, uuid, sessionID: String?
    let requestID: Int?
    let amount: Double?
    let merchantReference, merchantDefineData: String?
    let codeType: String?
    let codeTypeID: Int?
    let paymentURL: String?
    let success: Bool?
    let code, message: String?
    let errors: [String]?

    enum CodingKeys: String, CodingKey {
        case qrCodeData = "QrCodeData"
        case uuid = "UUID"
        case sessionID = "SessionID"
        case requestID = "RequestID"
        case amount = "Amount"
        case merchantReference = "MerchantReference"
        case merchantDefineData = "MerchantDefineData"
        case codeType = "CodeType"
        case codeTypeID = "CodeTypeID"
        case paymentURL = "PaymentUrl"
        case success, code, message, errors
    }
}
