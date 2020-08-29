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
    var principalRepository: PrincipalRepositoryProtocol
    let view: SplashViewControllerProtocol
    
    init(principalRepository: PrincipalRepositoryProtocol, view: SplashViewControllerProtocol) {
        self.principalRepository = principalRepository
        self.view = view
    }
    
    func startAnimation() {
        if principalRepository.currentUser == nil {
            let user = User(name: "Wesley Schultz",
                            username: "@wesleyschultz",
                            imageUrl: "https://www.thesun.co.uk/wp-content/uploads/2019/05/NINTCHDBPICT000490476354.jpg",
                            biography: "Writer & singer of The Lumineers.",
                            followers: 100_000,
                            followed: 1000,
                            views: 3_000_000)
            principalRepository.currentUser = user
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let self = self else { return }
            self.view.showMainTabBar()
        }
    }
}
