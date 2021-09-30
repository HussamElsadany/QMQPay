//
//  QatarPaySceneConfigurator.swift
//  QatarPay
//
//  Created by HE on 17/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

public class QatarPaySceneConfigurator {

    public static func configure(config: ConfigModel) -> QatarPayViewController {
        let viewController = QatarPayViewController.instance()
        let presenter = QatarPayScenePresenter(displayView: viewController)
        let interactor = QatarPaySceneInteractor(presenter: presenter)
        let router = QatarPaySceneRouter(controller: viewController)
        viewController.interactor = interactor
        viewController.dataStore = interactor
        viewController.router = router
        viewController.viewStore = presenter
        viewController.dataStore.config = config
        BaseURLConfig.shared.setCongif(environment: config.environment)
        return viewController
    }
}
