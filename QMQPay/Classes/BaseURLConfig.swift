//
//  BaseURLConfig.swift
//  NooqodyPay
//
//  Created by HE on 03/08/2021.
//

import Foundation

class BaseURLConfig {

    static let shared = BaseURLConfig()
    private var BaseURL: String = Constants.BASEURL.stagingEnvironment.rawValue

    func setCongif(environment: QatarPayEnviroment) {
        switch environment {
        case .QatarPayEnviromentSandBox:
            self.BaseURL = Constants.BASEURL.stagingEnvironment.rawValue
        case .QatarPayEnviromentProduction:
            self.BaseURL = Constants.BASEURL.productionEnvironment.rawValue
        }
    }

    func getBaseURL() -> String {
        return self.BaseURL
    }
}
