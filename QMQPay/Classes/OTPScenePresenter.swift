//
//  OTPScenePresenter.swift
//  QatarPaySDK
//
//  Created by Hussam Elsadany on 21/09/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol OTPScenePresentationLogic: AnyObject {
    func presentError(error: String)
    func presentError(error: Error)
    func presentSuccessPayment()
}

protocol OTPSceneViewStore: AnyObject {

}

class OTPScenePresenter: OTPScenePresentationLogic, OTPSceneViewStore {

    // MARK: Stored Properties
    weak var displayView: OTPSceneDisplayView?

    // MARK: Initializers
    required init(displayView: OTPSceneDisplayView) {
        self.displayView = displayView
    }
}

extension OTPScenePresenter {

    func presentError(error: String) {
        let viewModel = OTPScene.Error.ViewModel(message: error)
        self.displayView?.displayError(viewModel: viewModel)
    }

    func presentError(error: Error) {
        let viewModel = OTPScene.Error.ViewModel(message: error.localizedDescription)
        self.displayView?.displayError(viewModel: viewModel)
    }

    func presentSuccessPayment() {
        self.displayView?.displaySucessPayment()
    }
}
