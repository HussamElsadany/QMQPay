//
//  ServicePath.swift
//  Optio
//
//  Created by HE on 9/13/18.
//  Copyright © 2018 HE. All rights reserved.
//

import Foundation

public enum ServerPaths: String {
    case getToken         = "token"
    case getQrCodePayment = "api/MobileSDK/GeneratePaymentRequest"
    case initaitePayment  = "api/MobileSDK/InitiatePayment"
    case proceedPayment   = "api/MobileSDK/ProcessPayment"
}
