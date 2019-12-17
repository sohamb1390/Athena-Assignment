//
//  CategoryFetcher.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation
import Zip

struct CategoryFetcher {
    // MARK: - API Request
    func invokeAPIReuest(with completionHandler: @escaping Handler) {
        let networkAdapter = AthenaNetworkAdapter.shared
        networkAdapter.downloadRequestAPI(with: AthenaAPI.downloadFiles) { (result) in
            switch result {
            case .success(let url):
                if let url = url {
                    self.fileSave(from: url) { (url, error) in
                        completionHandler(url, error)
                    }
                } else {
                    completionHandler(nil, .clientError)
                }
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    // MARK: - File Save Handler
    private func fileSave(from location: URL, completionHandler: @escaping Handler) {
        // File already exists
        if let destination = FileManager.default.getDownloadFolderURL(), FileManager.default.fileExists(atPath: destination.path) {
            DPrint("File Exists at \(destination.path)")
            completionHandler(destination, nil)
        } else {
            // your destination file url
            guard let destination = FileManager.default.getDownloadFolderURL() else {
                completionHandler(nil, .clientError)
                return
            }
            
            DPrint(destination)

            do {
                // Moving file to documents directory
                try FileManager.default.moveItem(at: location, to: destination.appendingPathExtension("zip"))
                
                DPrint("file saved at: \(destination)")
                
                // Unzip downloaded file
                if let fileURL = unzipFile(at: destination, with: GeneralConstants.folderName) {
                    completionHandler(fileURL, nil)
                } else {
                    completionHandler(nil, .clientError)
                }
            } catch {
                DPrint(error.localizedDescription)
                completionHandler(nil, .clientError)
            }
        }
    }
    
    // MARK: - Unzip File
    private func unzipFile(at url: URL, with pathComponent: String) -> URL? {
        do {
            let unzipDirectory = try Zip.quickUnzipFile(url.appendingPathExtension("zip")) // Unzip
            return unzipDirectory
        } catch {
            DPrint(error.localizedDescription)
            return nil
        }
    }
}
