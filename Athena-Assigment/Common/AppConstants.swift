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
        case monograpList = "MonograpListCell"
    }
    
    enum Storyboard: String {
        case topicsList = "TopicsList"
        case monographList = "MonographList"
    }
}

enum JSONFiles {
    case Category
    case TopicList
    case TopicSubKey
    case Monograph
}

extension JSONFiles {
    var path: String {
        switch self {
        case .Category: return "\(GeneralConstants.detailedPath)list/CategoryList"
        case .TopicList: return "\(GeneralConstants.detailedPath)list/TopicsList"
        case .TopicSubKey: return "\(GeneralConstants.detailedPath)list/TopicsSubKey"
        case .Monograph: return "\(GeneralConstants.detailedPath)monograph/"
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
