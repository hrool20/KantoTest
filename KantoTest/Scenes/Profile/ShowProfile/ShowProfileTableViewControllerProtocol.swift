//
//  ShowProfileTableViewControllerProtocol.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol ShowProfileTableViewControllerProtocol: AlertHandlerProtocol {
    func updateRecordings(_ recordings: [Recording])
    func updateSecondNavigationBar(_ point: CGPoint, _ isHidden: Bool, _ alpha: CGFloat)
    func updateUser(_ user: User)
}
