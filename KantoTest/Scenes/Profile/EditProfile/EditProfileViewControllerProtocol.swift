//
//  EditProfileViewControllerProtocol.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/28/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol EditProfileViewControllerProtocol {
    func goBackToParent()
    func updateView(_ user: User)
}
