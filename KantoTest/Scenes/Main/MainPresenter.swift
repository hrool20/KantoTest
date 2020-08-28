//
//  MainPresenter.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

final class MainPresenter: MainPresenterProtocol {
    let view: MainTabBarControllerProtocol
    
    init(view: MainTabBarControllerProtocol) {
        self.view = view
    }
    
    func getViewControllers() -> [UIViewController] {
        let firstTab = UIViewController()
        firstTab.tabBarItem.title = nil
        firstTab.tabBarItem.image = #imageLiteral(resourceName: "tab_signal.png")
        firstTab.tabBarItem.selectedImage = #imageLiteral(resourceName: "tab_signal.png")
        
        let secondTab = UIViewController()
        secondTab.tabBarItem.title = nil
        secondTab.tabBarItem.image = #imageLiteral(resourceName: "tab_play")
        secondTab.tabBarItem.selectedImage = #imageLiteral(resourceName: "tab_play_filled")
        
        let thirdTab = UIViewController()
        thirdTab.tabBarItem.title = nil
        thirdTab.tabBarItem.image = #imageLiteral(resourceName: "tab_microphone")
        thirdTab.tabBarItem.selectedImage = #imageLiteral(resourceName: "tab_microphone_filled")
        
        let fourthTab = UIViewController()
        fourthTab.tabBarItem.title = nil
        fourthTab.tabBarItem.image = #imageLiteral(resourceName: "tab_bell")
        fourthTab.tabBarItem.selectedImage = #imageLiteral(resourceName: "tab_bell_filled")
        
        let fifthTab = Router.shared.getDefaultNavigation(rootViewController: Router.shared.getShowProfile())
        fifthTab.tabBarItem.title = nil
        fifthTab.tabBarItem.image = #imageLiteral(resourceName: "tab_profile.png").withRenderingMode(.alwaysOriginal)
        fifthTab.tabBarItem.selectedImage = #imageLiteral(resourceName: "tab_profile_filled").withRenderingMode(.alwaysOriginal)
        
        return [
            firstTab,
            secondTab,
            thirdTab,
            fourthTab,
            fifthTab
        ]
    }
}
