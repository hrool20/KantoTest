//
//  Router.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/25/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

final class Router {
    static let shared: Router = Router()
    
    func getMainTabBar() -> UIViewController {
        let viewController = MainTabBarController.get()
        return viewController
    }
    
    func getSplash() -> UIViewController {
        let viewController = SplashViewController.get()
        viewController.splashPresenter = SplashPresenter(view: viewController)
        return viewController
    }
}
