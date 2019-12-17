//
//  CategoryViewController.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: Variables
    private let viewModel = CategoryViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bind()
        fetchCategory()
    }
    
    // MARK: - Fetch Category
    private func fetchCategory() {
        showLoader(show: true)
        viewModel.fetchCategories()
    }
}

// MARK: - Binding
private extension CategoryViewController {
    func bind() {
        viewModel.category.bind { [weak self] (_) in
            DispatchQueue.main.async {
                self?.showLoader(show: false)
                self?.tableView.reloadData()
            }
        }
        
        // Error binding
        viewModel.error.bind { [weak self] (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showLoader(show: false)
                    self?.showAlert(with: NSLocalizedString("Error", comment: ""), description: error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusableItenfiers.categoryCell, for: indexPath)
        let text = viewModel.text(at: indexPath)
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

