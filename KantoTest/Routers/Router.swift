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
    
    func getSplash() -> UIViewController {
        let viewController = SplashViewController.get()
        return viewController
    }
}
