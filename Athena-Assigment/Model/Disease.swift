//
//  Disease.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

struct Disease: Codable {
    // MARK: Properties
    var id: Int?
    var title: String?
    var viewNodes: [DiseaseViewNode]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case viewNodes = "views"
    }
}

struct DiseaseViewNode: Codable {
    // MARK: Properties
    var id: String?
    var title: String?
    var type: String?
    var html: String?
    var sections: [DiseaseViewNodeSection]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case type
        case html
        case sections
    }
}

struct DiseaseViewNodeSection: Codable {
    // MARK: Properties
    var cells: [DiseaseViewNodeSectionCell]?
    
    private enum CodingKeys: String, CodingKey {
        case cells
    }
}

struct DiseaseViewNodeSectionCell: Codable {
    // MARK: Properties
    var target: String?
    var title: String?
    var type: String?
    
    private enum CodingKeys: String, CodingKey {
        case target
        case title
        case type
    }
}
