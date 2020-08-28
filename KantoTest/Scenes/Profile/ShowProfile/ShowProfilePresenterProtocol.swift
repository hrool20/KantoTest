//
//  ShowProfilePresenterProtocol.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol ShowProfilePresenterProtocol {
    func getTopBarSize(navigationBarHeight: CGFloat?) -> CGSize?
    func loadInformation()
    func updateSecondNavigationBar(headerHeight: CGFloat?, scrollViewY: CGFloat?)
}
