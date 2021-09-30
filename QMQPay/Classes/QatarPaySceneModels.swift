//
//  QatarPaySceneModels.swift
//  QatarPay
//
//  Created by HE on 17/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum QatarPayScene {
    enum QRCode { }
}

extension QatarPayScene.QRCode {
    struct ViewModel {
        let qrImage: UIImage?
        let amount: String
        let merchantName: String
    }
}
