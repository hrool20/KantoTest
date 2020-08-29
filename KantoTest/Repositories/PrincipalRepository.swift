//
//  PrincipalRepository.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/28/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class PrincipalRepository: PrincipalRepositoryProtocol {
    let userDefaultsHandler: UserDefaultsHandlerProtocol
    
    init(userDefaultsHandler: UserDefaultsHandlerProtocol) {
        self.userDefaultsHandler = userDefaultsHandler
    }
    
    var currentUser: User? {
        get {
            return userDefaultsHandler.custom(of: User.self, from: Constants.Keys.USER)
        }
        set {
            guard let newValue = newValue else {
                userDefaultsHandler.remove(from: Constants.Keys.USER)
                return
            }
            _ = userDefaultsHandler.save(newValue, to: Constants.Keys.USER)
        }
    }
    
    func getRecordings(success: @escaping ([Recording]?) -> Void) {
        AF.request("https://www.mocky.io/v2/5e669952310000d2fc23a20e",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .responseJSON { (response) in
                switch response.result {
                case .failure(_):
                    success(nil)
                case .success(let value):
                    let jsonObject = JSON(value)
                    let recordings = Recording.buildCollection(fromJSONArray: jsonObject.arrayValue)
                    success(recordings)
                }
        }
    }
}
