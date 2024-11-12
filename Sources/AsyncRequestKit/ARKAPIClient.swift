//
//  ARKAPIClient.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

import Foundation

public struct ARKAPIClient {

    let baseURL: String
    let networkDispatcher: ARKNetworkDispatcher!

    public init(baseURL: String, networkDispatcher: ARKNetworkDispatcher = ARKNetworkDispatcher()) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }


    /// Dispatches a Request using async/await and returns a Result
    /// - Parameter request: Request to Dispatch
    /// - Returns: A Result containing decoded data or an error
    public func dispatch<Request: ARKRequest>(_ request: Request) async throws -> Request.ReturnType {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL) else {
            throw ARKNetworkRequestError.badRequest
        }

        return try await networkDispatcher.dispatch(request: urlRequest, decoder: request.decoder)
    }
}
