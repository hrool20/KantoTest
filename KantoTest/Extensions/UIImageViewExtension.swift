//
//  UIImageViewExtension.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func setImage(with url: URL, placeholder: UIImage, options: SDWebImageOptions = .retryFailed, completed: ((UIImage?) -> Void)? = nil) {
        sd_setImage(with: url, placeholderImage: placeholder, options: options) { (image, error, cacheType, usedUrl) in
            completed?(image)
        }
    }
    
    func setImage(with url: URL, options: SDWebImageOptions = .retryFailed, completed: ((UIImage?) -> Void)? = nil) {
        setImage(with: url, placeholder: #imageLiteral(resourceName: "no_profile_image.jpg"), options: options) { (image) in
            completed?(image)
        }
    }
    
    func setImage(with url: URL, placeholder: URL, options: SDWebImageOptions = .retryFailed, completed: ((UIImage?) -> Void)? = nil) {
        let imageView = UIImageView()
        imageView.setImage(with: placeholder, options: [.retryFailed]) { (placeholderImage) in
            self.setImage(with: url, placeholder: placeholderImage ?? #imageLiteral(resourceName: "no_profile_image.jpg"), options: options) { (image) in
                completed?(image)
            }
        }
    }
}
