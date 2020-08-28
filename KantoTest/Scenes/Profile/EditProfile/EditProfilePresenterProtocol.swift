//
//  EditProfilePresenterProtocol.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/28/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol EditProfilePresenterProtocol {
    func getActionSheet(galleryClosure: @escaping() -> Void, cameraClosure: @escaping() -> Void) -> UIAlertController
    func loadUser(user: User)
    func saveUser(user: User, name: String?, username: String?, biography: String?, image: UIImage?)
}
