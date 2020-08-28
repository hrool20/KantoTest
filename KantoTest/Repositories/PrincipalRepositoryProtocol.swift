//
//  PrincipalRepositoryProtocol.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/28/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation

protocol PrincipalRepositoryProtocol {
    var currentUser: User? { get set }
    
    func getRecordings(success: @escaping([Recording]?) -> Void)
}
