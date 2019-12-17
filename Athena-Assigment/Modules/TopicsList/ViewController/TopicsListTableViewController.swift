//
//  TopicsListTableViewController.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 17/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import UIKit

class TopicsListTableViewController: UITableViewController {

    // MARK: Properties
    private (set) var viewModel: TopicsListViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView()
        title = viewModel?.screenTitle ?? ""
        viewModel?.setupTopics()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusableItenfiers.Cell.topicsList.rawValue, for: indexPath)

        // Configure the cell...
        let text = viewModel?.text(at: indexPath)
        cell.textLabel?.text = text ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let jsonFileIndex = viewModel?.jsonFileIndex(for: indexPath) {
            navigateToMonographList(with: jsonFileIndex)
        }
    }

    // MARK: - Navigation
    private func navigateToMonographList(with index: Int) {
        // Create `MonographListViewModel` with selected row
        let monographListViewModel = MonographListViewModel(with: index)
        
        if let monographListVC = UIStoryboard(name: ReusableItenfiers.Storyboard.monographList.rawValue, bundle: .main).instantiateViewController(identifier: MonographListTableViewController.className) as? MonographListTableViewController {
            monographListVC.bind(with: monographListViewModel)
            navigationController?.pushViewController(monographListVC, animated: true)
        }
    }
}

// MARK: - Binding
extension TopicsListTableViewController {
    func bind(with vm: TopicsListViewModel) {
        self.viewModel = vm
        
        self.viewModel?.topic.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Error binding
        self.viewModel?.error.bind { [weak self] (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(with: NSLocalizedString("Error", comment: ""), description: error.localizedDescription)
                }
            }
        }
    }
}
