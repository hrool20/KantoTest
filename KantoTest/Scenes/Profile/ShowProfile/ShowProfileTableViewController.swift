//
//  ShowProfileTableViewController.swift
//  KantoTest
//
//  Created by Hugo Andres Rosado on 8/26/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class ShowProfileTableViewController: UITableViewController {
    
    private var user: User?
    private var recordings: [Recording]?
    private var headerView: ShowProfileHeaderView!
    var showProfilePresenter: ShowProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        
        headerView = ShowProfileHeaderView.get(owner: self)
        let view = UIView(frame: headerView.frame)
        view.addSubview(headerView)
        
        tableView.backgroundColor = UIColor("#111111")
        tableView.register(ShowProfileRecordingTableViewCell.getNIB(), forCellReuseIdentifier: ShowProfileRecordingTableViewCell.reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.tableHeaderView = view
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        
        showProfilePresenter.loadRecordings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowProfileRecordingTableViewCell.reuseIdentifier, for: indexPath) as! ShowProfileRecordingTableViewCell
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
extension ShowProfileTableViewController: ShowProfileTableViewControllerProtocol {
    func updateRecordings(_ recordings: [Recording]) {
        self.recordings = recordings
        tableView.reloadData()
    }
}
