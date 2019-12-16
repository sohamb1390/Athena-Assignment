//
//  Topic.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

struct Topic: Codable {
    // MARK: Properties
    var uriPath: String?
    var content: [TopicContent]?
    
    private enum CodingKeys: String, CodingKey {
        case uriPath
        case content
    }
}

struct TopicContent: Codable {
    var index: Int
    var topicName: String
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.index = try container.decode(Int.self)
        self.topicName = try container.decode(String.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(index)
        try container.encode(topicName)
    }
}
