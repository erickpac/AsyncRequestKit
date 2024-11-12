//
//  ResourcesHelper.swift
//  AsyncRequestKit
//
//  Created by epac on 12/11/24.
//

import Foundation

struct ResourcesHelper {

    enum ResourcePath: String {
        case post
        case posts
        case incorrectTypePost = "incorrect_type_post"
    }

    enum URLConstants {
        static let apiURL = "https://jsonplaceholder.typicode.com/posts"
    }

    enum HTTPSettings {
        static let version = "2.0"
        static let successCode = 200
        static let notFoundCode = 404
        static let errorCode = 409
        static let requestTimeout: TimeInterval = 1.0
    }

    static func loadTestData(from resourcePath: ResourcePath) -> Data? {
        guard let url = Bundle.module.url(forResource: resourcePath.rawValue, withExtension: "json") else {
            return nil
        }

        do {
            return try Data(contentsOf: url, options: .mappedIfSafe)
        } catch {
            return nil
        }
    }

    static func DummyURLSession() -> URLSession {
        let urlSessionConfig = URLSessionConfiguration.ephemeral
        urlSessionConfig.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: urlSessionConfig)
    }
}
