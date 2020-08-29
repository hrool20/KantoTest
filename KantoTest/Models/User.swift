//
//  User.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: Codable {
    var name: String
    var username: String
    var imageUrl: String
    var image: String?
    var biography: String
    var followers: Int
    var followed: Int
    var views: Int
    
    init() {
        name = ""
        username = ""
        imageUrl = ""
        biography = ""
        followers = 0
        followed = 0
        views = 0
    }
    
    init(name: String, username: String, imageUrl: String, biography: String, followers: Int, followed: Int, views: Int) {
        self.name = name
        self.username = username
        self.imageUrl = imageUrl
        self.biography = biography
        self.followers = followers
        self.followed = followed
        self.views = views
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        self.init(name: jsonObject["name"].stringValue,
                  username: jsonObject["user_name"].stringValue,
                  imageUrl: jsonObject["img"].stringValue,
                  biography: jsonObject["biography"].stringValue,
                  followers: jsonObject["followers"].intValue,
                  followed: jsonObject["followed"].intValue,
                  views: jsonObject["views"].intValue)
    }
    
    func getImage() -> UIImage? {
        guard let image = image,
            let data = Data(base64Encoded: image, options: .ignoreUnknownCharacters) else {
                return nil
        }
        return UIImage(data: data)
    }
    
    func saveImage(_ image: UIImage?) {
        let data = image?.pngData()
        self.image = data?.base64EncodedString(options: .lineLength64Characters)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [User] {
        return jsonArray.map { (jsonObject) -> User in
            User(fromJSONObject: jsonObject)
        }
    }
}
