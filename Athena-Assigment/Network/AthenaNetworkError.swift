//
//  AthenaNetworkError.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

/// Defines all the network response codes. This enum also  provides a method which returns any of the `AthenaNetworkError` enum value based on the given error code. Besides, it gives you the localized error description based on  the `AthenaNetworkError` enum value.
enum AthenaNetworkError: Error {
    case unavailable
    case serverError
    case clientError
    case success
    case redirection
    case unknown
    case validationError(String)
    
    /// Returns any of the `AthenaNetworkError` enum value based on the given error code
    /// - Parameters:
    ///    - errorCode: API Response Code
    /// - Returns: Any type of `AthenaNetworkError`
    static func getErrorType(fromErrorCode errorCode: Int) -> AthenaNetworkError {
        switch errorCode {
        case 100..<200: return .unavailable
        case 200..<300: return .success
        case 300..<400: return .redirection
        case 400..<500: return .clientError
        case 500..<600: return .serverError
        default: return .unknown
        }
    }
}

extension AthenaNetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unavailable:
            return NSLocalizedString(
                "Not Found",
                comment: ""
            )
        case .clientError:
            return NSLocalizedString(
                "Client Side Error",
                comment: ""
            )
        case .serverError:
            return NSLocalizedString(
                "Server Error",
                comment: ""
            )
        case .success:
            return NSLocalizedString(
                "Success",
                comment: ""
            )
        case .redirection:
            return NSLocalizedString(
                "Request Redirected",
                comment: ""
            )
        case .validationError(let desc):
            return NSLocalizedString(
                desc,
                comment: ""
            )
        case .unknown:
            return NSLocalizedString(
                "Unknown Error",
                comment: ""
            )
        }
    }
}
