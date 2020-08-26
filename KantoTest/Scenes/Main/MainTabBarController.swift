//
//  MainTabBarController.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/25/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var mainPresenter: MainPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        selectedViewController?.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        selectedViewController?.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.layer.shadowRadius = 6.0
        tabBar.layer.shadowColor = UIColor.gray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        tabBar.layer.shadowOpacity = 0.8
        tabBar.layer.masksToBounds = false
    }
    
    func loadTabBar() {
        tabBar.barTintColor = UIColor("#111111")
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .white
        setViewControllers(mainPresenter.getViewControllers(), animated: true)
    }

}
extension MainTabBarController: MainTabBarControllerProtocol {
    
}
