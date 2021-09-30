//
//  QatarPayScenePresenter.swift
//  QatarPay
//
//  Created by HE on 17/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol QatarPayScenePresentationLogic: AnyObject {
    func present(error: String)
    func present(error: Error)
    func present(qrData: QRPaymentModel, configModel: ConfigModel)
    func presentOTP()
    func presentSuccessPayment(processPayment: ProcessPaymentModel)
}

protocol QatarPaySceneViewStore: AnyObject {
    var qrCodeViewModel: QatarPayScene.QRCode.ViewModel? { get set }
}

class QatarPayScenePresenter: QatarPayScenePresentationLogic, QatarPaySceneViewStore {

    // MARK: Stored Properties
    weak var displayView: QatarPaySceneDisplayView?

    var qrCodeViewModel: QatarPayScene.QRCode.ViewModel?

    // MARK: Initializers
    required init(displayView: QatarPaySceneDisplayView) {
        self.displayView = displayView
    }
}

extension QatarPayScenePresenter {

    func present(error: String) {
        self.displayView?.displayError(errorMessage: error)
    }

    func present(error: Error) {
        self.displayView?.displayError(errorMessage: error.localizedDescription)
    }

    func present(qrData: QRPaymentModel, configModel: ConfigModel) {
        if let qrCodeData = qrData.qrCodeData {
            let image = self.generateQrCodeImage(qrCodeData)
            let viewModel = QatarPayScene.QRCode.ViewModel(qrImage: image,
                                                           amount: String(format: "%.2f", configModel.amount),
                                                           merchantName: configModel.merchantName)
            self.displayView?.displayQrCode(viewModel: viewModel)
        }
    }

    func presentOTP() {
        self.displayView?.displayOTPScreen()
    }

    func presentSuccessPayment(processPayment: ProcessPaymentModel) {
        self.displayView?.displaySuccess(processPayment: processPayment)
    }
}

private extension QatarPayScenePresenter {

    func generateQrCodeImage(_ text: String) -> UIImage? {
        if let decodedData = Data(base64Encoded: text) {
            let image = UIImage(data: decodedData)
            return image
        }
        return nil
    }
}
