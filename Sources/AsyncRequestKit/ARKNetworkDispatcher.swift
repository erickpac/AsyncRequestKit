//
//  ARKNetworkDispatcher.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

import Foundation

public struct ARKNetworkDispatcher {

    let urlSession: URLSession!

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Dispatches an URLRequest using async/await and returns a Result
    /// - Parameter request: URLRequest
    /// - Returns: A Result with the provided decoded data or an error
    public func dispatch<ReturnType: Decodable>(request: URLRequest, decoder: JSONDecoder) async throws -> ReturnType {
        do {
            let (data, response) = try await urlSession.data(for: request, delegate: nil)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ARKNetworkRequestError.unknownError
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw httpError(httpResponse.statusCode)
            }

            do {
                return try decoder.decode(ReturnType.self, from: data)
            } catch(let error) {
                throw ARKNetworkRequestError.decodingError(error.localizedDescription)
            }
        } catch {
            throw handleError(error)
        }
    }
}

extension ARKNetworkDispatcher {

    /// Parses a HTTP StatusCode and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> ARKNetworkRequestError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 402, 405...499: return .error4xx(statusCode)
        case 500: return .serverError
        case 501...599: return .error5xx(statusCode)
        default: return .unknownError
        }
    }

    /// Parses URLSession data errors and return proper ones
    /// - Parameter error: URLSession data error
    /// - Returns: Readable NetworkRequestError
    private func handleError(_ error: Error) -> ARKNetworkRequestError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError(error.localizedDescription)
        case let urlError as URLError:
            return .urlSessionFailed(urlError)
        case let error as ARKNetworkRequestError:
            return error
        default:
            return .unknownError
        }
    }
}
