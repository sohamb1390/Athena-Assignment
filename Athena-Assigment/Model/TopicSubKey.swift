//
//  TopicSubKey.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

struct TopicSubKey: Codable {
    // MARK: Properties
    var uriPath: String?
    var content: [[[Int]]]?
    
    private enum CodingKeys: String, CodingKey {
        case uriPath
        case content
    }
}
