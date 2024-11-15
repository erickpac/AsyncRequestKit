import Foundation
import Testing
@testable import AsyncRequestKit

struct AsyncRequestKitTests {

    @Test("Test successful response for fetching posts")
    func successfulFetchPostsResponse() async throws {
        // Given
        guard let testData = ResourcesHelper.loadTestData(from: .posts) else {
            Issue.record("Could not load test data")
            return
        }

        guard let url = URL(string: ResourcesHelper.URLConstants.apiURL) else {
            Issue.record("Could not create URL")
            return
        }

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url,
                                           statusCode: ResourcesHelper.HTTPSettings.successCode,
                                           httpVersion: ResourcesHelper.HTTPSettings.version,
                                           headerFields: nil)!
            return (response, testData)
        }

        let dispatcher = ARKNetworkDispatcher(urlSession: ResourcesHelper.DummyURLSession())
        let apiClient = ARKAPIClient(baseURL: ResourcesHelper.URLConstants.apiURL, networkDispatcher: dispatcher)

        // When
        do {
            let result: [Post] = try await apiClient.dispatch(ARKRequests.GetPosts())

            // Then
            #expect(!result.isEmpty)
        } catch {
            Issue.record("Request failed with error: \(error.localizedDescription)")
        }
    }

    @Test("Test 404 response for fetching a single post")
    func fetchSinglePostNotFoundResponse() async throws {
        // Given
        guard let testData = ResourcesHelper.loadTestData(from: .post) else {
            Issue.record("Could not load test data")
            return
        }

        guard let url = URL(string: ResourcesHelper.URLConstants.apiURL) else {
            Issue.record("Could not create URL")
            return
        }

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: url,
                                           statusCode: ResourcesHelper.HTTPSettings.notFoundCode,
                                           httpVersion: ResourcesHelper.HTTPSettings.version,
                                           headerFields: nil)!
            return (response, testData)
        }

        let dispatcher = ARKNetworkDispatcher(urlSession: ResourcesHelper.DummyURLSession())
        let apiClient = ARKAPIClient(baseURL: ResourcesHelper.URLConstants.apiURL, networkDispatcher: dispatcher)

        // When
        do {
            let _: Post = try await apiClient.dispatch(ARKRequests.GetPost(id: 1))
            Issue.record("Expected error to be thrown")
        } catch {
            // Then
            #expect(error as? ARKNetworkRequestError == .notFound)
        }
    }
}

