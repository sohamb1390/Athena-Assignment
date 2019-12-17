//
//  CategoryViewModel.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

final class CategoryViewModel {
    // MARK: Properties
    private (set) var category: Bindable<Category?> = Bindable(nil)
    private (set) var error: Bindable<AthenaNetworkError?> = Bindable(nil)
    private var fetcher: CategoryFetcher?
    var screenTitle: String {
        return NSLocalizedString("Categories", comment: "")
    }
    
    // MARK: - Constructor
    init() {
        self.fetcher = CategoryFetcher()
    }
    
    // MARK: - Fetch Categories
    func fetchCategories() {
        if let fileURL = FileManager.default.getDownloadFolderURL()?.appendingPathComponent(JSONFiles.category.path).appendingPathExtension("json"), FileManager.default.fileExists(atPath: fileURL.path) {
            if let category = decodeCategory(from: fileURL) {
                self.category.value = category
            } else {
                error.value = .clientError
            }
        } else {
            fetcher?.invokeAPIReuest(with: { [weak self] (fileURL, error) in
                if let error = error {
                    self?.error.value = error
                } else if let fileURL = fileURL {
                    let finalURL = fileURL.appendingPathComponent(JSONFiles.category.path).appendingPathExtension("json")
                    let category = self?.decodeCategory(from: finalURL)
                    self?.category.value = category
                } else {
                    self?.error.value = .clientError
                }
            })
        }
    }
    
    private func decodeCategory(from url: URL) -> Category? {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let category = try JSONDecoder().decode(Category.self, from: data)
                return category
            } catch (let error) {
                // handle error
                DPrint(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
    // MARK: - Datasource
    func numberOfRows() -> Int {
        return category.value?.content?.count ?? 0
    }
    
    func text(at indexPath: IndexPath) -> String {
        if let contents = category.value?.content, contents.count > indexPath.row {
            return contents[indexPath.row].category
        }
        return ""
    }
}
