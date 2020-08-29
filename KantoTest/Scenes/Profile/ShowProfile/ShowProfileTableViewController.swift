//
//  ShowProfileTableViewController.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit
import AVFoundation

class ShowProfileTableViewController: UITableViewController {
    
    private var user: User?
    private var recordings: [Recording]?
    private var headerView: ShowProfileHeaderView!
    private var secondNavigationBar: UIView?
    private var player: AVPlayer?
    var showProfilePresenter: ShowProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = ShowProfileHeaderView.get(owner: self)
        headerView.delegate = self
        if let topBarSize = showProfilePresenter.getTopBarSize(navigationBarHeight: navigationController?.navigationBar.bounds.height) {
            secondNavigationBar = UIView(frame: CGRect(origin: .zero, size: topBarSize))
            secondNavigationBar?.backgroundColor = navigationController?.navigationBar.barTintColor
            view.addSubview(secondNavigationBar!)
        }
        
        tableView.register(ShowProfileRecordingTableViewCell.getNIB(), forCellReuseIdentifier: ShowProfileRecordingTableViewCell.reuseIdentifier)
        tableView.backgroundColor = UIColor("#111111")
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        
        showProfilePresenter.loadInformation()
        showProfilePresenter.updateSecondNavigationBar(headerHeight: nil, scrollViewY: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.isTranslucent = false
        let navigationBar = navigationController?.navigationBar
        guard let attribute = navigationBar?.titleTextAttributes?.first(where: { (attribute) -> Bool in
            attribute.key == .foregroundColor
        }) else {
            return
        }
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: (attribute.value as! UIColor).withAlphaComponent(1)
        ]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(CGSize(width: tableView.bounds.width, height: 0)).height
            var headerFrame = headerView.frame
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }
    
    // MARK: ScrollView functions
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        showProfilePresenter.updateSecondNavigationBar(headerHeight: headerView.bounds.height, scrollViewY: scrollView.contentOffset.y)
        if scrollView.contentOffset.y - 100 < 0 {
            scrollView.bounces = false
        } else {
            scrollView.bounces = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowProfileRecordingTableViewCell.reuseIdentifier, for: indexPath) as! ShowProfileRecordingTableViewCell
        cell.delegate = self
        cell.recording = recordings?[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }

}
extension ShowProfileTableViewController: ShowProfileTableViewControllerProtocol, ShowProfileHeaderViewDelegate, SPRecordingTableViewCellDelegate {
    func updateRecordings(_ recordings: [Recording]) {
        self.recordings = recordings
        tableView.reloadData()
    }
    
    func updateSecondNavigationBar(_ point: CGPoint, _ isHidden: Bool, _ alpha: CGFloat) {
        secondNavigationBar?.frame.origin = point
        secondNavigationBar?.isHidden = isHidden
        secondNavigationBar?.alpha = alpha
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white.withAlphaComponent(alpha)
        ]
    }
    
    func updateUser(_ user: User) {
        self.user = user
        headerView.user = user
        navigationItem.title = user.name
    }
    
    // MARK: ShowProfileHeaderViewDelegate
    
    func showEditProfile() {
        let editProfile = Router.shared.getEditProfile(user: user)
        editProfile.hidesBottomBarWhenPushed = true
        navigationController?.show(editProfile, sender: nil)
    }
    
    // MARK: SPRecordingTableViewCellDelegate
    
    func didVideoStarts(id: String?, player: AVPlayer?) {
        guard let index = recordings?.firstIndex(where: { (recording) -> Bool in
            return recording.id == id
        }), let recordings = recordings else {
            show(.alert, message: Constants.Localizable.VIDEO_NOT_AVAILABLE)
            return
        }
        
        self.player?.pause()
        self.player = nil
        self.player = player
        
        var array: [IndexPath] = []
        if index - 2 >= 0 {
            array.append(IndexPath(item: index - 2, section: 0))
            array.append(IndexPath(item: index - 1, section: 0))
        } else if index - 1 >= 0 {
            array.append(IndexPath(item: index - 1, section: 0))
        }
        if index + 2 < recordings.count {
            array.append(IndexPath(item: index + 2, section: 0))
            array.append(IndexPath(item: index + 1, section: 0))
        } else if index + 1 < recordings.count {
            array.append(IndexPath(item: index + 1, section: 0))
        }
        
        tableView.beginUpdates()
        tableView.reloadRows(at: array, with: .fade)
        tableView.endUpdates()
    }
    
    func showAlert(message: String) {
        show(.alert, message: message)
    }
}
