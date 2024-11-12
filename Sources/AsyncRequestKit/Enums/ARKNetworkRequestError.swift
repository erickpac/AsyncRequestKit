//
//  ARKNetworkRequestError.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

import Foundation

public enum ARKNetworkRequestError: LocalizedError, Equatable {

    case invalidRequest
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case error4xx(_ code: Int)
    case serverError
    case error5xx(_ code: Int)
    case decodingError(_ description: String)
    case urlSessionFailed(_ error: URLError)
    case unknownError
}
