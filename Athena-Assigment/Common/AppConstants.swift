//
//  AppConstants.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

struct GeneralConstants {
    static let folderName = "Athena-Assignment/"
    static let detailedPath = "assignment/disease/"
}

struct ReusableItenfiers {
    enum Cell: String {
        case category = "CategoryCell"
        case topicsList = "TopicsListCell"
    }
    
    enum Storyboard: String {
        case topicsList = "TopicsList"
    }
}

enum JSONFiles {
    case category
    case TopicList
    case TopicSubKey
}

extension JSONFiles {
    var path: String {
        switch self {
        case .category: return "\(GeneralConstants.detailedPath)list/CategoryList"
        case .TopicList: return "\(GeneralConstants.detailedPath)list/TopicsList"
        case .TopicSubKey: return "\(GeneralConstants.detailedPath)list/TopicsSubKey"
        }
    }
}

/// Debug Mode for print
func DPrint(_ items: Any...) {
    #if DEBUG
    
    var startIdx = items.startIndex
    let endIdx = items.endIndex
    
    repeat {
        Swift.print(items[startIdx])
        startIdx += 1
    } while startIdx < endIdx
    
    #endif
}
