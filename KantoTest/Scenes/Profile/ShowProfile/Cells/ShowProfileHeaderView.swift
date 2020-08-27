//
//  ShowProfileHeaderView.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class ShowProfileHeaderView: UIView {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var firstBorderView: UIView!
    @IBOutlet weak var secondBorderView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var socialView: UIView!
    @IBOutlet weak var followersStackView: UIStackView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followersNameLabel: UILabel!
    @IBOutlet weak var followedStackView: UIStackView!
    @IBOutlet weak var followedLabel: UILabel!
    @IBOutlet weak var followedNameLabel: UILabel!
    @IBOutlet weak var viewsStackView: UIStackView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var viewsNameLabel: UILabel!
    static let reuseIdentifier: String = "recordingHeaderViewCell"
    var user: User? {
        didSet {
            guard let user = user else {
                return
            }
            if let imageUrl = URL(string: user.imageUrl) {
                userImageView.setImage(with: imageUrl) { [weak self] (_) in
                    self?.layoutSubviews()
                }
            }
            userFullNameLabel.text = user.name
            usernameLabel.text = user.username
            descriptionTextView.text = user.biography
            
            followersLabel.text = "\(user.followers)"
            followedLabel.text = "\(user.followed)"
            viewsLabel.text = "\(user.views)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        parentView.layer.cornerRadius = parentView.bounds.width / 20
        parentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        [userImageView, firstBorderView, secondBorderView, editProfileButton].forEach { (view) in
            view?.layer.cornerRadius = view!.bounds.height / 2
        }
        [firstBorderView, secondBorderView].forEach { (view) in
            view?.layer.borderWidth = 1.0
            view?.layer.borderColor = (view == firstBorderView) ? UIColor("#A279F9")?.cgColor : UIColor("#7E4DF4")?.cgColor
        }
        socialView.layer.cornerRadius = socialView.bounds.height / 5
    }
    
    @IBAction func didEditProdile(_ sender: UIButton) {
    }
    
}
