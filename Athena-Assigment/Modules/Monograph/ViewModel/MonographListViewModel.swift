//
//  MonographListViewModel.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 17/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

final class MonographListViewModel {
    // MARK: Properties
    private (set) var jsonFileIndex: Int
    private (set) var monograph: Bindable<Disease?> = Bindable(nil)
    private (set) var error: Bindable<AthenaNetworkError?> = Bindable(nil)
    private (set) var screenTitle: Bindable<String> = Bindable("")
    private var monographTitles: [String] = []
    
    // MARK: - Constructor
    init(with index: Int) {
        self.jsonFileIndex = index
    }
    
    // MARK: - Setup Data
    func setupMonograph() {
        // Get the topic sub keys
        if let fileURL = FileManager.default.getDownloadFolderURL() {
            let finalURL = fileURL.appendingPathComponent(JSONFiles.Monograph.path).appendingPathComponent("\(jsonFileIndex)").appendingPathExtension("json")
            
            // Get the Monograph
            // Get all the titles of the Monograph Root Node
            if let monograph = decodeMonograph(from: finalURL), let viewNodes = monograph.viewNodes, !viewNodes.isEmpty, let rootNode = viewNodes.filter({ $0.id == "root" }).first {
                
                for section in rootNode.sections ?? [] where section.cells?.isEmpty == false {
                    monographTitles.append(contentsOf: section.cells!.map({ $0.title }).compactMap({ $0 }))
                }
                
                self.screenTitle.value = monograph.title ?? ""
                self.monograph.value = monograph
                return
            }
        }
        error.value = .clientError
    }
    
    // MARK: Decoders
    private func decodeMonograph(from url: URL) -> Disease? {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let monograph = try JSONDecoder().decode(Disease.self, from: data)
                return monograph
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
        return monographTitles.count
    }
    
    func text(at indexPath: IndexPath) -> String {
        if monographTitles.count > indexPath.row {
            let monographTitle = monographTitles[indexPath.row]
            return monographTitle
        }
        return ""
    }
}
