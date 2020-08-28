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
    
    func getActionSheet(pickerController: UIImagePickerController) -> UIAlertController {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: Constants.Localizable.CAMERA, style: .default) { [weak self] (_) in
            pickerController.sourceType = .camera
            self?.askForPickerAuthorization(pickerController)
        }
        let galleryAction = UIAlertAction(title: Constants.Localizable.GALLERY, style: .default) { [weak self] (_) in
            pickerController.sourceType = .photoLibrary
            self?.askForPickerAuthorization(pickerController)
        }
        let cancelAction = UIAlertAction(title: Constants.Localizable.CANCEL, style: .cancel, handler: nil)
        
        [galleryAction, cameraAction, cancelAction].forEach { (alertAction) in
            actionSheet.addAction(alertAction)
        }
        
        return actionSheet
    }
    
    private func askForPickerAuthorization(_ pickerController: UIImagePickerController) {
        pickerController.askForAuthorization(success: { [weak self] in
            self?.view.presentPickerController(pickerController)
        }) { [weak self] in
            self?.view.show(.alert, message: Constants.Localizable.ACCESS_DENIED)
        }
    }
    
    func loadUser(user: User) {
        // TODO: send analytic data
        view.updateView(user)
    }
    
    func saveUser(user: User, name: String?, username: String?, biography: String?, image: UIImage?) {
        guard let name = name,
            let username = username,
            let biography = biography else {
                view.show(.alert, message: Constants.Localizable.SOME_FIELDS_EMPTY)
                return
        }
        guard image != nil || (name != user.name && username != user.username && biography != user.biography) else {
            view.show(.alert, message: Constants.Localizable.FIELDS_NOT_CHANGED)
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
