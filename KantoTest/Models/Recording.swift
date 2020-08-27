//
//  Recording.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import SwiftyJSON

class Recording {
    var user: User
    var title: String
    var recordViewUrl: String
    var previewImageUrl: String
    var reproductions: Int
    
    init() {
        user = User()
        title = ""
        recordViewUrl = ""
        previewImageUrl = ""
        reproductions = 0
    }
    
    init(user: User, title: String, recordViewUrl: String, previewImageUrl: String, reproductions: Int) {
        self.user = user
        self.title = title
        self.recordViewUrl = recordViewUrl
        self.previewImageUrl = previewImageUrl
        self.reproductions = reproductions
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        self.init(user: User(fromJSONObject: jsonObject["profile"]),
                  title: jsonObject["description"].stringValue,
                  recordViewUrl: jsonObject["record_video"].stringValue,
                  previewImageUrl: jsonObject["preview_img"].stringValue,
                  reproductions: jsonObject["reproductions"].intValue)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Recording] {
        return jsonArray.map { (jsonObject) -> Recording in
            Recording(fromJSONObject: jsonObject)
        }
    }
}
