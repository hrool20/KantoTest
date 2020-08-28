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
    
    // MARK: AlertHandlerProtocol
    func show(_ style: UIAlertController.Style, title: String?, message: String, closure: @escaping(() -> Void)) {
        let alertController = UIAlertController(title: title ?? "Kanto Test", message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            closure()
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showQuestion(_ style: UIAlertController.Style, title: String?, message: String, yes yesTitle: String, no noTitle: String, closure: @escaping(() -> Void)) {
        let alertController = UIAlertController(title: title ?? "Kanto Test", message: message, preferredStyle: style)
        let yesAction = UIAlertAction(title: yesTitle, style: .destructive) { (_) in
            closure()
        }
        let noAction = UIAlertAction(title: noTitle, style: .default) { (_) in
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        alertController.preferredAction = noAction
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
