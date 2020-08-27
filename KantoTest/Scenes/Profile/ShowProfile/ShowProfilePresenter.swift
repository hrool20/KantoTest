//
//  ShowProfilePresenter.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

final class ShowProfilePresenter: ShowProfilePresenterProtocol {
    let view: ShowProfileTableViewControllerProtocol
    
    init(view: ShowProfileTableViewControllerProtocol) {
        self.view = view
    }
    
    func loadRecordings() {
        AF.request("https://www.mocky.io/v2/5e669952310000d2fc23a20e",
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil)
            .responseJSON { [weak self] (response) in
                guard let self = self else { return }
                
                switch response.result {
                case .failure(_):
                    self.view.updateRecordings([])
                case .success(let value):
                    let jsonObject = JSON(value)
                    let recordings = Recording.buildCollection(fromJSONArray: jsonObject.arrayValue)
                    self.view.updateRecordings(recordings)
                }
        }
    }
}
