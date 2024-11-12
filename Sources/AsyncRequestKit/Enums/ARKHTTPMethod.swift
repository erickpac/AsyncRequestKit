//
//  ARKHTTPMethod.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

public enum ARKHTTPMethod: String, Sendable, CaseIterable {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
