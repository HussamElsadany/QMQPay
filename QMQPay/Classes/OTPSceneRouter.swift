//
//  OTPSceneRouter.swift
//  QatarPaySDK
//
//  Created by Hussam Elsadany on 21/09/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol OTPSceneRoutingLogic: AnyObject {
    typealias Controller = OTPSceneDisplayView & OTPViewController
}

class OTPSceneRouter {

    // MARK: Stored Properties
    var viewController: Controller?

    // MARK: Initializers
    required init(controller: Controller?) {
        self.viewController = controller
    }
}

extension OTPSceneRouter: OTPSceneRoutingLogic {

}
