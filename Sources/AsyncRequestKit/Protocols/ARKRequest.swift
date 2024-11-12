//
//  Request.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

import Foundation

public typealias ARKHTTPParams = [String: Any]

public protocol ARKRequest {

    var path: String { get }
    var method: ARKHTTPMethod { get }
    var contentType: String { get }
    var queryParams: ARKHTTPParams? { get }
    var body: ARKHTTPParams? { get }
    var headers: [String: String]? { get }
    var decoder: JSONDecoder { get }
    associatedtype ReturnType: Decodable
}

public extension ARKRequest {

    /// Defaults
    var method: ARKHTTPMethod { return .get }
    var contentType: String { return "application/json" }
    var queryParams: ARKHTTPParams? { return nil }
    var body: ARKHTTPParams? { return nil }
    var headers: [String: String]? { return nil }
    var decoder: JSONDecoder { return JSONDecoder() }
}

extension ARKRequest {

    /// Serializes an HTTP parameters dictionary to a JSON Data object.
    ///
    /// This method takes a dictionary of HTTP parameters and encodes it into a JSON Data object.
    ///
    /// - Parameter params: A dictionary containing the HTTP parameters to be serialized.
    /// - Returns: A Data object containing the JSON-encoded representation of the HTTP parameters.
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard
            let params = params,
            let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {

            return nil
        }

        return httpBody
    }

    /// Generates an array of `URLQueryItem` from a dictionary of HTTP parameters.
    ///
    /// This method takes a dictionary of HTTP parameters and converts it into an array of `URLQueryItem` objects,
    /// which can be used to construct the query string of a URL.
    ///
    /// - Parameter params: A dictionary containing the HTTP parameters to be converted.
    /// - Returns: An array of `URLQueryItem` objects representing the HTTP parameters.
    private func queryItemsFrom(params: ARKHTTPParams?) -> [URLQueryItem]? {
        guard let params = params else { return nil }
        return params.map {
            URLQueryItem(name: $0.key, value: $0.value as? String)
        }
    }

    /// Converts the current `Request` instance into a `URLRequest`.
    ///
    /// This method constructs a `URLRequest` using the provided base URL and the properties of the `Request` instance.
    ///
    /// - Parameter baseURL: The base URL of the API to be used for constructing the full request URL.
    /// - Returns: A configured `URLRequest` ready to be used for network operations.
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }

        urlComponents.path = "\(urlComponents.path)\(path)"
        urlComponents.queryItems = queryItemsFrom(params: queryParams)

        guard let finalURL = urlComponents.url else { return nil }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers ?? [:]
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")

        return request
    }
}
