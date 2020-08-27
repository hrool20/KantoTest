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
    
    func getDefaultNavigation(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barTintColor = .clear
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
    
    func getMainTabBar() -> UIViewController {
        let viewController = MainTabBarController.get()
        viewController.mainPresenter = MainPresenter(view: viewController)
        viewController.loadTabBar()
        return viewController
    }
    
    func getShowProfile() -> UIViewController {
        let viewController = ShowProfileTableViewController.get()
        viewController.showProfilePresenter = ShowProfilePresenter(view: viewController)
        return viewController
    }
    
    func getSplash() -> UIViewController {
        let viewController = SplashViewController.get()
        viewController.splashPresenter = SplashPresenter(view: viewController)
        return viewController
    }
}
