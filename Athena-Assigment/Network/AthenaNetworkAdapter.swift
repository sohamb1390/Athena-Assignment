//
//  AthenaNetworkAdapter.swift
//  Athena-Assigment
//
//  Created by Soham Bhattacharjee on 16/12/19.
//  Copyright © 2019 Soham Bhattacharjee. All rights reserved.
//

import Foundation

final class AthenaNetworkAdapter {
    
    // MARK: - Properties
    private let session: URLSession
    static let shared = AthenaNetworkAdapter(with: URLSession.shared)

    // MARK: - Constructor
    
    private init(with session: URLSession) {
        self.session = session
    }
    
    // MARK: - API Call
    /// Triggers API call with a completion call back containing the rsponse data and an Error instance
    /// - Parameters:
    ///    - request: `AthenaAPIRequestkProtocol` type parameter which consists of all the details required for triggering the API
    ///    - onCompletionHandler: A Completion callback containing an optional location `URL` and `AthenaNetworkError` instance
    func downloadRequestAPI(with request: AthenaAPIRequestProtocol, onCompletionHandler: @escaping ((_ result: Result<URL?, AthenaNetworkError>) -> Void)) {
        
        guard let baseURL = request.baseURL else {
            onCompletionHandler(.failure(.clientError))
            return
        }
        
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.path),
                                    cachePolicy: request.cachePolicy,
                                    timeoutInterval: request.requestTimeOutInterval)
        
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        if let requestBody = request.requestBody {
            urlRequest.httpBody = requestBody
        }
        
        for key in request.header.keys {
            urlRequest.setValue(request.header[key], forHTTPHeaderField: key)
        }

        session.downloadTask(with: urlRequest) { (location, response, error) in
            if let location = location {
                onCompletionHandler(.success(location))
            } else if let _ = error, let response = response as? HTTPURLResponse {
                onCompletionHandler(.failure(AthenaNetworkError.getErrorType(fromErrorCode: response.statusCode)))
            } else {
                onCompletionHandler(.failure(.unknown))
            }
        }.resume()
    }
}
