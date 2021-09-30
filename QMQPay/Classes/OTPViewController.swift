//
//  OTPViewController.swift
//  QatarPaySDK
//
//  Created by Hussam Elsadany on 21/09/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol OTPViewControllerDelegate: AnyObject {
    func paymentDidFinishPayment(viewController: OTPViewController, processPayment: ProcessPaymentModel)
}

protocol OTPSceneDisplayView: AnyObject {
    func displayError(viewModel: OTPScene.Error.ViewModel)
    func displaySucessPayment()
}

class OTPViewController: UIViewController {

    @IBOutlet private weak var otpView: DigitInputView!
    @IBOutlet private weak var proceedButton: UIButton!

    public weak var delegate: OTPViewControllerDelegate? = nil

    var interactor: OTPSceneBusinessLogic!
    var dataStore: OTPSceneDataStore!
    var viewStore: OTPSceneViewStore!
    var router: OTPSceneRoutingLogic!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.otpView.numberOfDigits = 6
    }

    @IBAction func proceed(_ sender: Any) {
        if self.otpView.text.isEmpty {
            self.otpView.errorShake()
            return
        }
        self.proceedButton.startLoading()
        self.interactor.processPayment(otp: self.otpView.text)
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension OTPViewController: OTPSceneDisplayView {

    func displayError(viewModel: OTPScene.Error.ViewModel) {
        DispatchQueue.main.async {
            self.proceedButton.stopLoading()
            let alertController = UIAlertController(title: "Error", message: viewModel.message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func displaySucessPayment() {
        DispatchQueue.main.async {
            self.proceedButton.stopLoading()
            self.dismiss(animated: true, completion: nil)
        }
        guard let processPayment = self.dataStore.processPayment else {
            return
        }
        self.delegate?.paymentDidFinishPayment(viewController: self, processPayment: processPayment)
    }
}
