//
//  OTPSceneConfigurator.swift
//  QatarPaySDK
//
//  Created by Hussam Elsadany on 21/09/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class OTPSceneConfigurator {

    static func configure() -> OTPViewController {
        let viewController = OTPViewController.instance()
        let presenter = OTPScenePresenter(displayView: viewController)
        let interactor = OTPSceneInteractor(presenter: presenter)
        let router = OTPSceneRouter(controller: viewController)
        viewController.interactor = interactor
        viewController.dataStore = interactor
        viewController.router = router
        viewController.viewStore = presenter
        return viewController
    }
}
