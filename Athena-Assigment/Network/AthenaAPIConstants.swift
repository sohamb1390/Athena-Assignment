//
//  AthenaAPIConstants.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

/// A completion closure which will return the file URL and an optional error instance
typealias Handler = (_ fileURL: URL?, _ error: AthenaNetworkError?) -> Void

/// HTTP Methods
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

/// Athena download Service URLs
struct AthenaService {
    static let baseURL = "https://cdn.dev.epocrates.com/"
}

/// API Path Enum
enum AthenaAPI {
    case downloadFiles
}

extension AthenaAPI: AthenaAPIRequestProtocol {
    var baseURL: URL? {
        return URL(string: AthenaService.baseURL)
    }
    
    var requestBody: Data? {
        switch self {
        case .downloadFiles: return nil
        }
    }
    
    var header: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return URLRequest.CachePolicy.reloadIgnoringCacheData
    }
    
    var requestTimeOutInterval: TimeInterval {
        return 30.0
    }

    var path: String {
        switch self {
        case .downloadFiles: return "formulary/config/assignment.zip"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .downloadFiles: return .GET
        }
    }
}
