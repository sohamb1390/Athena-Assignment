//
//  Category.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

struct Category: Codable {
    // MARK: Properties
    var uriPath: String?
    var content: [CategoryContent]?
    
    private enum CodingKeys: String, CodingKey {
        case uriPath
        case content
    }
}

struct CategoryContent: Codable {
    var category: String
    var index: Int
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.category = try container.decode(String.self)
        self.index = try container.decode(Int.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(category)
        try container.encode(index)
    }
}
