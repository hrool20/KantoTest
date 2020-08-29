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
    // Handlers
    private let userDefaultsHandler: UserDefaultsHandlerProtocol
    // Repositories
    private let principalRepository: PrincipalRepositoryProtocol
    
    init() {
        userDefaultsHandler = UserDefaultsHandler()
        
        principalRepository = PrincipalRepository(userDefaultsHandler: userDefaultsHandler)
    }
    
    func getDefaultNavigation(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barTintColor = UIColor("#111111")
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        return navigationController
    }
    
    func getEditProfile(user: User?) -> UIViewController {
        let viewController = EditProfileViewController.get()
        viewController.editProfilePresenter = EditProfilePresenter(principalRepository: principalRepository, view: viewController)
        viewController.user = user
        return viewController
    }
    
    func getMainTabBar() -> UIViewController {
        let viewController = MainTabBarController.get()
        viewController.mainPresenter = MainPresenter(view: viewController)
        viewController.loadTabBar()
        return viewController
    }
    
    func getShowProfile() -> UIViewController {
        let viewController = ShowProfileTableViewController.get()
        viewController.showProfilePresenter = ShowProfilePresenter(principalRepository: principalRepository, view: viewController)
        return viewController
    }
    
    func getSplash() -> UIViewController {
        let viewController = SplashViewController.get()
        viewController.splashPresenter = SplashPresenter(principalRepository: principalRepository, view: viewController)
        return viewController
    }
}
