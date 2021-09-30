//
//  QatarPaySceneRouter.swift
//  QatarPay
//
//  Created by HE on 17/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol QatarPaySceneRoutingLogic: AnyObject {
    typealias Controller = QatarPaySceneDisplayView & QatarPayViewController

    func routeToOTPScene(pinCode: String, configModel: ConfigModel, iniatePayment: IniatePaymentModel)
}

class QatarPaySceneRouter {

    // MARK: Stored Properties
    var viewController: Controller?

    // MARK: Initializers
    required init(controller: Controller?) {
        self.viewController = controller
    }
}

extension QatarPaySceneRouter: QatarPaySceneRoutingLogic {

    func routeToOTPScene(pinCode: String, configModel: ConfigModel, iniatePayment: IniatePaymentModel) {
        let viewController = OTPSceneConfigurator.configure()
        viewController.dataStore.configModel = configModel
        viewController.dataStore.pinCode = pinCode
        viewController.dataStore.initatePayment = iniatePayment
        viewController.modalPresentationStyle = .overFullScreen
        viewController.delegate = self.viewController
        self.viewController?.present(viewController, animated: true, completion: nil)
    }
}
