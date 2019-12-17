//
//  TopicsListViewModel.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 17/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

final class TopicsListViewModel {
    // MARK: Properties
    private (set) var categoryIndex: Int
    private (set) var topic: Bindable<[TopicContent]> = Bindable([])
    private (set) var error: Bindable<AthenaNetworkError?> = Bindable(nil)

    var screenTitle: String {
        return NSLocalizedString("Topics", comment: "")
    }
    
    // MARK: - Constructor
    init(with index: Int) {
        self.categoryIndex = index
    }
    
    // MARK: - Setup Data
    func setupTopics() {
        // Get the topic sub keys
        if let fileURL = FileManager.default.getDownloadFolderURL() {
            let finalURL = fileURL.appendingPathComponent(JSONFiles.TopicSubKey.path).appendingPathExtension("json")
            
            if let topicsSubkey = decodeTopicsSubkeys(from: finalURL), let contents = topicsSubkey.content, contents.count > 1 {
                let topicsIndices = contents[1]
                
                // Get the indices locating at the category index
                if topicsIndices.count > categoryIndex {
                    let topicsIndex = topicsIndices[categoryIndex]
                    getTopics(for: topicsIndex)
                }
                return
            }
        }
        error.value = .clientError
    }
    
    private func getTopics(for indices: [Int]) {
        if let fileURL = FileManager.default.getDownloadFolderURL() {
            let finalURL = fileURL.appendingPathComponent(JSONFiles.TopicList.path).appendingPathExtension("json")
            if let topic = decodeTopicsList(from: finalURL), let contents = topic.content, !contents.isEmpty {
                var topicContents: [TopicContent] = []
                for index in indices {
                    let finalIndex = index - 1
                    if contents.count > finalIndex {
                        let topicContent = contents[finalIndex]
                        topicContents.append(topicContent)
                    }
                }
                self.topic.value = topicContents
                return
            }
        }
        error.value = .clientError
    }
    
    // MARK: Decoders
    private func decodeTopicsSubkeys(from url: URL) -> TopicSubKey? {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let topicSubKey = try JSONDecoder().decode(TopicSubKey.self, from: data)
                return topicSubKey
            } catch (let error) {
                // handle error
                DPrint(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
    private func decodeTopicsList(from url: URL) -> Topic? {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let topic = try JSONDecoder().decode(Topic.self, from: data)
                return topic
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
        return topic.value.count
    }
    
    func text(at indexPath: IndexPath) -> String {
        if topic.value.count > indexPath.row {
            let topicContent = topic.value[indexPath.row]
            return topicContent.topicName
        }
        return ""
    }
}
