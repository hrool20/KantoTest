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
    var showProfilePresenter: ShowProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Profile"
        
        tableView.backgroundColor = UIColor("#111111")
        tableView.register(ShowProfileRecordTableViewCell.getNIB(), forCellReuseIdentifier: ShowProfileRecordTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        
        showProfilePresenter.loadRecordings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordings?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowProfileRecordTableViewCell.reuseIdentifier, for: indexPath) as! ShowProfileRecordTableViewCell
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
