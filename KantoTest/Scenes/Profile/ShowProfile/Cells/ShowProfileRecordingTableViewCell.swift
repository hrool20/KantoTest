//
//  ShowProfileRecordingTableViewCell.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit
import AVFoundation

protocol SPRecordingTableViewCellDelegate: class {
    func didVideoStarts(id: String?, player: AVPlayer?)
    func showAlert(message: String)
}

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
    weak var delegate: SPRecordingTableViewCellDelegate?
    private var isVideoPlaying: Bool!
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var timeObserver: Any?
    private var reproductions: Int! {
        didSet {
            guard reproductions != nil else {
                return
            }
            recording?.reproductions = reproductions
            reproductionsLabel.text = "\(reproductions ?? 0) \((reproductions == 1) ? Constants.Localizable.REPRODUCTION.lowercased() : Constants.Localizable.REPRODUCTIONS.lowercased())"
        }
    }
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        player = nil
        playerLayer = nil
        isVideoPlaying = false
        
        likeLabel.text = Constants.Localizable.LIKE
        
        NotificationCenter.default.addObserver(self, selector: #selector(didVideoEnds), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        parentView.layer.cornerRadius = parentView.bounds.width / 25
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        playIconView.layer.cornerRadius = playIconView.bounds.height / 2
        playImageView.image = playImageView.image?.withRenderingMode(.alwaysTemplate)
        playImageView.tintColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        videoProgressView.progress = 0.0
        
        didVideoEnds()
    }
    
    @objc private func didPlayOrPauseVideo() {
        guard let video = recording?.recordViewUrl,
            let videoUrl = URL(string: video) else {
                delegate?.showAlert(message: Constants.Localizable.DEFAULT_ERROR_MESSAGE)
                return
        }
        if playerLayer == nil {
            loadPlayerLayer(url: videoUrl)
        }
        if isVideoPlaying {
            playerLayer?.player?.pause()
        } else {
            playerLayer?.player?.play()
        }
        playIconView.isHidden = !isVideoPlaying
        isVideoPlaying = !isVideoPlaying
    }
    
    private func loadPlayerLayer(url: URL) {
        player = AVPlayer(url: url)
        let interval = CMTime(value: 1, timescale: 2)
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (progress) in
            guard let self = self, let duration = self.player?.currentItem?.duration else { return }
            let progressSeconds = CMTimeGetSeconds(progress)
            let durationSeconds = CMTimeGetSeconds(duration)
            self.videoProgressView.progress = Float(progressSeconds / durationSeconds)

            if self.videoProgressView.progress == 1 {
                self.videoProgressView.progress = 0
            }
        }
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoImageView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        videoImageView.layer.addSublayer(playerLayer!)
        videoImageView.image = nil
        reproductions += 1
        delegate?.didVideoStarts(id: recording?.id, player: player)
    }
    
    @objc func didVideoEnds() {
        if let timeObserver = timeObserver {
            player?.removeTimeObserver(timeObserver)
        }
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
        if let songImageUrl = URL(string: recording?.previewImageUrl ?? "") {
            videoImageView.setImage(with: songImageUrl)
        }
        playIconView.isHidden = false
        isVideoPlaying = false
    }
    
    private func getTitle(_ name: String, _ title: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: userNameLabel.font.pointSize)
        ]
        let sangAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: userNameLabel.font.pointSize, weight: .light)
        ]
        let userName = NSAttributedString(string: name, attributes: attributes)
        let sang = NSAttributedString(string: " \(Constants.Localizable.SANG.lowercased()) ", attributes: sangAttributes)
        let songName = NSAttributedString(string: title, attributes: attributes)
        
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(userName)
        mutableAttributedString.append(sang)
        mutableAttributedString.append(songName)
        
        return mutableAttributedString
    }
    
}
