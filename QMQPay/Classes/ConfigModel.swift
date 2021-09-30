//
//  ConfigModel.swift
//  NooqodyPay
//
//  Created by HE on 19/07/2021.
//

import Foundation

public enum QatarPayEnviroment {
    case QatarPayEnviromentSandBox
    case QatarPayEnviromentProduction
}

public struct ConfigModel {
    let environment: QatarPayEnviroment
    let token: String
    let projectId: String
    let merchantName: String
    let merchantId: String
    let merchantDefinedData: String
    let merchantEmail: String
    let privateKey: String
    let privateKeyId: String
    let amount: Double
    let description: String

    public init(environment: QatarPayEnviroment, token: String, projectId: String, merchantName: String, merchantDefinedData: String, merchantId: String, merchantEmail: String, privateKey: String, privateKeyId: String, amount: Double, description: String) {
        self.environment = environment
        self.token = token
        self.projectId = projectId
        self.merchantName = merchantName
        self.merchantId = merchantId
        self.merchantDefinedData = merchantDefinedData
        self.merchantEmail = merchantEmail
        self.privateKey = privateKey
        self.privateKeyId = privateKeyId
        self.amount = amount
        self.description = description
    }
}
