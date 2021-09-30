//
//  PaymentListViewController.swift
//  NooqodyPay
//
//  Created by HE on 17/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public protocol QatarPayDelegate: AnyObject {
    func paymentSuccess(controller: QatarPayViewController, processPayment: ProcessPaymentModel)
    func paymentFailed(controller: QatarPayViewController, message: String)
}

protocol QatarPaySceneDisplayView: AnyObject {
    func displayError(errorMessage: String)
    func displayQrCode(viewModel: QatarPayScene.QRCode.ViewModel)
    func displayOTPScreen()
    func displaySuccess(processPayment: ProcessPaymentModel)
}

public class QatarPayViewController: UIViewController {

    @IBOutlet private weak var activityIndecator: UIActivityIndicatorView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var merchantNameLabel: UILabel!
    @IBOutlet private weak var totalAmountLabel: UILabel!
    @IBOutlet private weak var qrImageView: UIImageView!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var pinCodeView: DigitInputView!
    @IBOutlet private weak var payButton: UIButton!
    @IBOutlet private weak var shadowView1: UIView!
    @IBOutlet private weak var shadowView2: UIView!

    public weak var delegate: QatarPayDelegate? = nil

    var interactor: QatarPaySceneBusinessLogic!
    var dataStore: QatarPaySceneDataStore!
    var viewStore: QatarPaySceneViewStore!
    var router: QatarPaySceneRoutingLogic!

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isHidden = true
        self.shadowView1.isHidden = true
        self.shadowView2.isHidden = true
        self.interactor.getQRPayment()
    }

    @IBAction private func payNow(_ sender: UIButton) {
        if self.emailField.text!.isEmpty {
            self.emailField.errorShake()
            return
        }

        if self.pinCodeView.text.isEmpty {
            self.pinCodeView.errorShake()
            return
        }
        self.payButton.startLoading()
        self.interactor.initiatePayment(pinCode: pinCodeView.text, email: self.emailField.text!)
    }
}

extension QatarPayViewController: QatarPaySceneDisplayView {

    func displayError(errorMessage: String) {
        DispatchQueue.main.async {
            self.payButton.stopLoading()
            self.delegate?.paymentFailed(controller: self, message: errorMessage)
        }
    }

    func displayQrCode(viewModel: QatarPayScene.QRCode.ViewModel) {
        DispatchQueue.main.async {
            self.scrollView.isHidden = false
            self.shadowView1.isHidden = false
            self.shadowView2.isHidden = false
            self.activityIndecator.stopAnimating()
            self.qrImageView.image = viewModel.qrImage
            self.merchantNameLabel.text = viewModel.merchantName
            self.totalAmountLabel.text = viewModel.amount + " QAR"
        }
    }

    func displayOTPScreen() {
        DispatchQueue.main.async {
            self.payButton.stopLoading()
        }
        guard let initatePayment = self.dataStore.initatePayment , let configModel = self.dataStore.config else {
            return
        }
        DispatchQueue.main.async {
            self.router.routeToOTPScene(pinCode: self.pinCodeView.text,
                                        configModel: configModel,
                                        iniatePayment: initatePayment)
        }
    }

    func displaySuccess(processPayment: ProcessPaymentModel) {
        DispatchQueue.main.async {
            self.payButton.stopLoading()
            self.delegate?.paymentSuccess(controller: self, processPayment: processPayment)
        }
    }
}

extension QatarPayViewController: OTPViewControllerDelegate {

    func paymentDidFinishPayment(viewController: OTPViewController, processPayment: ProcessPaymentModel) {
        DispatchQueue.main.async {
            self.delegate?.paymentSuccess(controller: self, processPayment: processPayment)
        }
    }
}
