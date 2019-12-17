//
//  MonographListTableViewController.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 17/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import UIKit

class MonographListTableViewController: UITableViewController {

    // MARK: Properties
    private (set) var viewModel: MonographListViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView()
        viewModel?.setupMonograph()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusableItenfiers.Cell.monograpList.rawValue, for: indexPath)

        // Configure the cell...
        let text = viewModel?.text(at: indexPath)
        cell.textLabel?.text = text ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Binding
extension MonographListTableViewController {
    func bind(with vm: MonographListViewModel) {
        self.viewModel = vm
        
        self.viewModel?.monograph.bind { [weak self] (_) in
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
        
        // Screen title
        self.viewModel?.screenTitle.bind { [weak self] (title) in
            DispatchQueue.main.async {
                self?.title = title
            }
        }
    }
}
