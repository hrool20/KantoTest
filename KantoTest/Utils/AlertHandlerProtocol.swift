//
//  AlertHandlerProtocol.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/28/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol AlertHandlerProtocol {
    func show(_ style: UIAlertController.Style, title: String?, message: String, closure: @escaping(() -> Void))
    func showQuestion(_ style: UIAlertController.Style, title: String?, message: String, yes okTitle: String, no cancelTitle: String, closure: @escaping(() -> Void))
}
extension AlertHandlerProtocol {
    func show(_ style: UIAlertController.Style, message: String, closure: (() -> Void)? = nil) {
        show(style, title: nil, message: message) {
            closure?()
        }
    }
    
    func showQuestion(_ style: UIAlertController.Style, message: String, yes yesTitle: String, no noTitle: String, closure: (() -> Void)? = nil) {
        showQuestion(style, title: nil, message: message, yes: yesTitle, no: noTitle) {
            closure?()
        }
    }
    
    func showQuestion(_ style: UIAlertController.Style, message: String, closure: @escaping(() -> Void)) {
        showQuestion(style, title: nil, message: message, yes: "Yes", no: "No", closure: closure)
    }
}
