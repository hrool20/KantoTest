//
//  UIViewExtension.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    private static var NIBName: String {
        return String(describing: self)
    }
    
    static func get(owner: Any? = nil) -> Self {
        guard let view = Bundle.main.loadNibNamed(NIBName, owner: owner, options: nil)?[0] as? Self else {
            fatalError("This should never happen")
        }
        return view
    }
    
    static func getNIB() -> UINib {
        return UINib(nibName: self.NIBName, bundle: nil)
    }
}
