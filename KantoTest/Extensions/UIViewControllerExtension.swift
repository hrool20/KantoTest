//
//  UIViewControllerExtension.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/25/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    private static var NIBName: String {
        return String(describing: self)
    }
    
    static func get(with bundle: Bundle? = nil) -> Self {
        return Self(nibName: NIBName, bundle: bundle)
    }
    
    // MARK: Transition between viewControllers
    func crossDisolveTransition(to viewController: UIViewController, duration: TimeInterval = 0.6) {
        guard let window = UIApplication.shared.keyWindow else {
            fatalError()
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: duration, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
}
