//
//  ShowProfilePresenter.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

final class ShowProfilePresenter: ShowProfilePresenterProtocol {
    var principalRepository: PrincipalRepositoryProtocol
    let view: ShowProfileTableViewControllerProtocol
    
    init(principalRepository: PrincipalRepositoryProtocol, view: ShowProfileTableViewControllerProtocol) {
        self.principalRepository = principalRepository
        self.view = view
    }
    
    func getTopBarSize(navigationBarHeight: CGFloat?) -> CGSize? {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        guard let navigationBarHeight = navigationBarHeight else {
            return nil
        }
        return CGSize(width: UIScreen.main.bounds.width, height: statusBarHeight + navigationBarHeight)
    }
    
    func loadInformation() {
        if let user = principalRepository.currentUser {
            view.updateUser(user)
        } else {
            // TODO: Show an alert.
        }
        
        principalRepository.getRecordings { [weak self] (recordings) in
            guard let self = self else { return }
            if let recordings = recordings {
                self.view.updateRecordings(recordings)
            } else {
                // TODO: Show an alert.
            }
        }
    }
    
    func updateSecondNavigationBar(headerHeight: CGFloat?, scrollViewY: CGFloat?) {
        guard let headerHeight = headerHeight, let scrollViewY = scrollViewY else {
            view.updateSecondNavigationBar(.zero, true, 0)
            return
        }
        
        let heightLeft: CGFloat = (headerHeight - scrollViewY > 0) ? headerHeight - scrollViewY : 0
        let beginning: CGFloat = headerHeight / 4
        
        let point = CGPoint(x: 0, y: scrollViewY)
        let isHidden: Bool
        let alpha: CGFloat
        
        if heightLeft < beginning {
            isHidden = false
            alpha = 1 - (heightLeft / beginning)
        } else if heightLeft == 0 {
            isHidden = false
            alpha = 1
        } else {
            isHidden = true
            alpha = 0
        }
        
        view.updateSecondNavigationBar(point, isHidden, alpha)
    }
}
