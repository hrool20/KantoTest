//
//  ShowProfileRecordingTableViewCell.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit
import AVFoundation

class ShowProfileRecordingTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoProgressView: UIProgressView!
    @IBOutlet weak var videoSubView: UIView!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoOptionsView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var reproductionsLabel: UILabel!
    @IBOutlet weak var playIconView: UIView!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    static let reuseIdentifier: String = "recordingViewCell"
    private var playerLayer: AVPlayerLayer?
    var recording: Recording? {
        didSet {
            guard let recording = recording else {
                return
            }
            
            if let userImageUrl = URL(string: recording.user.imageUrl) {
                userImageView.setImage(with: userImageUrl) { [weak self] (_) in
                    self?.layoutSubviews()
                }
            }            
            userNameLabel.attributedText = getTitle(recording.user.name, recording.title)
            if let songImageUrl = URL(string: recording.previewImageUrl) {
                videoImageView.setImage(with: songImageUrl) { [weak self] (_) in
                    self?.layoutSubviews()
                }
            }
            songNameLabel.text = recording.title
            reproductions = recording.reproductions
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didPlayOrPauseVideo))
            videoOptionsView.addGestureRecognizer(tapGesture)
        }
    }
    private var reproductions: Int! {
        didSet {
            guard reproductions != nil else {
                return
            }
            reproductionsLabel.text = "\(reproductions ?? 0) \((reproductions == 1) ? Constants.Localizable.REPRODUCTION.lowercased() : Constants.Localizable.REPRODUCTIONS.lowercased())"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeLabel.text = Constants.Localizable.LIKE
        
        NotificationCenter.default.addObserver(self, selector: #selector(didVideoEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        parentView.layer.cornerRadius = parentView.bounds.width / 25
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        playIconView.layer.cornerRadius = playIconView.bounds.height / 2
        playImageView.image = playImageView.image?.withRenderingMode(.alwaysTemplate)
        playImageView.tintColor = .white
    }
    
    @objc private func didPlayOrPauseVideo() {
        guard let video = recording?.recordViewUrl,
            let videoUrl = URL(string: video) else {
                return
        }
        guard playerLayer != nil else {
            let player = AVPlayer(url: videoUrl)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = videoImageView.bounds
            playerLayer?.videoGravity = .resizeAspectFill
            videoImageView.image = nil
            videoImageView.layer.addSublayer(playerLayer!)
            playVideo()
            recording?.reproductions += 1
            reproductions += 1
            return
        }
        
        playVideo()
    }
    
    private func playVideo() {
        if videoOptionsView.tag == 0 {
            videoOptionsView.tag = 1
            playIconView.isHidden = true
            playerLayer?.player?.play()
        } else {
            videoOptionsView.tag = 0
            playIconView.isHidden = false
            playerLayer?.player?.pause()
        }
    }
    
    @objc func didVideoEnd() {
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        if let songImageUrl = URL(string: recording?.previewImageUrl ?? "") {
            videoImageView.setImage(with: songImageUrl)
        }
        videoOptionsView.tag = 0
        playIconView.isHidden = false
    }
    
    private func getTitle(_ name: String, _ title: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: userNameLabel.font.pointSize)
        ]
        let userName = NSAttributedString(string: name, attributes: attributes)
        let sang = NSAttributedString(string: " \(Constants.Localizable.SANG.lowercased()) ")
        let songName = NSAttributedString(string: title, attributes: attributes)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(userName)
        mutableAttributedString.append(sang)
        mutableAttributedString.append(songName)
        
        return mutableAttributedString
    }
    
}
