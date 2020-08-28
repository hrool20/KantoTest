//
//  EditProfileViewController.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/28/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var updatePhotoButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var biographyTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    private var newImage: UIImage?
    var editProfilePresenter: EditProfilePresenterProtocol!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Edit Profile"
        
        [nameTextField, usernameTextField, biographyTextField].forEach { (textField) in
            let placehodler = textField?.placeholder ?? ""
            let attributedString = NSAttributedString(string: placehodler, attributes: [
                .foregroundColor: UIColor.lightGray
            ])
            textField?.attributedPlaceholder = attributedString
        }
        
        editProfilePresenter.loadUser(user: user)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        [userImageView, updatePhotoButton, saveButton].forEach { (view) in
            view?.layer.cornerRadius = view!.bounds.height / 2
        }
    }
    
    @IBAction func didSaveUser(_ sender: UIButton) {
        editProfilePresenter.saveUser(user: user,
                                      name: nameTextField.text,
                                      username: usernameTextField.text,
                                      biography: biographyTextField.text,
                                      image: newImage)
    }
    
    @IBAction func didUpdateImage(_ sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let imageActionSheet = editProfilePresenter.getActionSheet(pickerController: pickerController)
        present(imageActionSheet, animated: true, completion: nil)
    }
    
    private func askForPickerAuthorization(_ pickerController: UIImagePickerController) {
        pickerController.askForAuthorization(success: { [weak self] in
            DispatchQueue.main.async {
                self?.present(pickerController, animated: true, completion: nil)
            }
        }) { [weak self] in
            self?.show(.alert, message: "Access denied.")
        }
    }

}
extension EditProfileViewController: EditProfileViewControllerProtocol {
    func goBackToParent() {
        navigationController?.popViewController(animated: true)
    }
    
    func presentPickerController(_ pickerController: UIImagePickerController) {
        present(pickerController, animated: true, completion: nil)
    }
    
    func updateView(_ user: User) {
        if let image = user.getImage() {
            userImageView.image = image
        } else if let imageUrl = URL(string: user.imageUrl) {
            userImageView.setImage(with: imageUrl)
        }
        nameTextField.text = user.name
        usernameTextField.text = user.username
        biographyTextField.text = user.biography
    }
}
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        newImage = info[.editedImage] as? UIImage
        userImageView.image = newImage
    }
}
