//
//  UIImagePickerControllerExtension.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/28/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import AVFoundation
import Photos
import UIKit

extension UIImagePickerController {
    func askForAuthorization(success: @escaping() -> Void, failure: (() -> Void)? = nil) {
        switch sourceType {
        case .camera:
            AVCaptureDevice.requestAccess(for: .video) { (isGranted) in
                guard isGranted else {
                    failure?()
                    return
                }
                success()
            }
        case .photoLibrary, .savedPhotosAlbum:
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    success()
                case .denied, .notDetermined:
                    failure?()
                case .restricted:
                    print("PHPhotoLibrary restricted.")
                    failure?()
                @unknown default:
                    break
                }
            }
        @unknown default:
            break
        }
    }
}
