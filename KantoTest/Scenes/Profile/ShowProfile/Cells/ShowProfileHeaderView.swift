//
//  ShowProfileHeaderView.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

protocol ShowProfileHeaderViewDelegate: class {
    func showEditProfile()
}

class ShowProfileHeaderView: UIView {

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
    private var gradientLayer: CAGradientLayer!
    weak var delegate: ShowProfileHeaderViewDelegate?
    var user: User? {
        didSet {
            guard let user = user else {
                return
            }
            if let image = user.getImage() {
                userImageView.image = image
            } else if let imageUrl = URL(string: user.imageUrl) {
                userImageView.setImage(with: imageUrl) { [weak self] (_) in
                    self?.layoutSubviews()
                }
            }
            userFullNameLabel.text = user.name
            usernameLabel.text = user.username
            descriptionTextView.text = user.biography
            
            followersLabel.text = user.followers.useAbbreviation()
            followedLabel.text = user.followed.useAbbreviation()
            viewsLabel.text = user.views.useAbbreviation()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor("#6A4BF3")?.cgColor ?? UIColor.clear.cgColor,
            UIColor("#9646F5")?.cgColor ?? UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0.0, 0.7]
        layer.insertSublayer(gradientLayer, at: 0)
        
        editProfileButton.setTitle(Constants.Localizable.EDIT_PROFILE_TITLE, for: .normal)
        followersNameLabel.text = Constants.Localizable.FOLLOWERS
        followedNameLabel.text = Constants.Localizable.FOLLOWED
        viewsNameLabel.text = Constants.Localizable.VIEWS
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
        [layer, gradientLayer].forEach { (layer) in
            layer?.cornerRadius = bounds.width / 20
            layer?.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        [userImageView, firstBorderView, secondBorderView, editProfileButton].forEach { (view) in
            view?.layer.cornerRadius = view!.bounds.height / 2
        }
        [firstBorderView, secondBorderView].forEach { (view) in
            view?.layer.borderWidth = 2.0
            view?.layer.borderColor = (view == firstBorderView) ? UIColor("#7E4DF4")?.cgColor : UIColor("#A279F9")?.cgColor
        }
        socialView.layer.cornerRadius = socialView.bounds.height / 5
    }
    
    @IBAction func didEditProdile(_ sender: UIButton) {
        delegate?.showEditProfile()
    }

}
