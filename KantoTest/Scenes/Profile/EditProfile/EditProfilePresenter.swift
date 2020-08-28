//
//  EditProfilePresenter.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/28/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

final class EditProfilePresenter: EditProfilePresenterProtocol {
    var principalRepository: PrincipalRepositoryProtocol
    let view: EditProfileViewControllerProtocol
    
    init(principalRepository: PrincipalRepositoryProtocol, view: EditProfileViewControllerProtocol) {
        self.principalRepository = principalRepository
        self.view = view
    }
    
    func getActionSheet(galleryClosure: @escaping () -> Void, cameraClosure: @escaping () -> Void) -> UIAlertController {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (_) in
            galleryClosure()
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
            cameraClosure()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        [galleryAction, cameraAction, cancelAction].forEach { (alertAction) in
            actionSheet.addAction(alertAction)
        }
        
        return actionSheet
    }
    
    func loadUser(user: User) {
        // TODO: send analytic data
        view.updateView(user)
    }
    
    func saveUser(user: User, name: String?, username: String?, biography: String?, image: UIImage?) {
        guard let name = name,
            let username = username,
            let biography = biography else {
                // TODO: Show an alert
                return
        }
        guard image != nil || (name != user.name && username != user.username && biography != user.biography) else {
            // TODO: Show an alert
            return
        }
        
        user.name = name
        user.username = username
        user.biography = biography
        user.saveImage(image)
        principalRepository.currentUser = user
        
        view.goBackToParent()
    }
}
