//
//  SplashViewController.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/25/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var kantoImageView: UIImageView!
    var splashPresenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        splashPresenter.startAnimation()
    }

}
extension SplashViewController: SplashViewControllerProtocol {
    func showMainTabBar() {
        let mainTabBar = Router.shared.getMainTabBar()
        crossDisolveTransition(to: mainTabBar)
    }
}
