//
//  ProcessPaymentModel.swift
//  QatarPaySDK
//
//  Created by Hussam Elsadany on 21/09/2021.
//

public struct ProcessPaymentModel: Codable {
    public let transactionDescription, requestDate, merchantReference, merchantName: String?
    public let merchantLogo, merchantCompanyName: String?
    public let merchantPhoneNumber: String?
    public let merchantMobile: String?
    public let amount: Int?
    public let sessionID, uuid, merchantEmail, qpan: String?
    public let successURL: String?
    public let success: Bool?
    public let code, message: String?
    public let errors: [String]?
    public let transactionNumber: String?
    public let transactionStatus: Bool?
    public let merchantDefinedData: String?
    public let merchantPaymentRequestID: Int?
    public let paidByUser, transactionCode, transactionCompletedDate: String?

    enum CodingKeys: String, CodingKey {
        case transactionDescription = "TransactionDescription"
        case requestDate = "RequestDate"
        case merchantReference = "MerchantReference"
        case merchantName = "MerchantName"
        case merchantLogo = "MerchantLogo"
        case merchantCompanyName = "MerchantCompanyName"
        case merchantPhoneNumber = "MerchantPhoneNumber"
        case merchantMobile = "MerchantMobile"
        case amount = "Amount"
        case sessionID = "SessionID"
        case uuid = "UUID"
        case merchantEmail = "MerchantEmail"
        case qpan = "QPAN"
        case successURL = "SuccessURL"
        case success, code, message, errors
        case transactionNumber = "TransactionNumber"
        case transactionStatus = "TransactionStatus"
        case merchantDefinedData = "MerchantDefinedData"
        case merchantPaymentRequestID = "MerchantPaymentRequestID"
        case paidByUser = "PaidByUser"
        case transactionCode = "TransactionCode"
        case transactionCompletedDate = "TransactionCompletedDate"
    }
}
