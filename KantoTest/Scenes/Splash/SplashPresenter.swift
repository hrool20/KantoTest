//
//  SplashPresenter.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/25/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

final class SplashPresenter: SplashPresenterProtocol {
    let view: SplashViewControllerProtocol
    
    init(view: SplashViewControllerProtocol) {
        self.view = view
    }
    
    func startAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let self = self else { return }
            self.view.showMainTabBar()
        }
    }
}
