//
//  ARKNetworkErrorTests.swift
//  AsyncRequestKit
//
//  Created by epac on 12/11/24.
//

import Testing
@testable import AsyncRequestKit

struct ARKNetworkErrorTests {

    @Test("ARKNetworkRequestError should correctly compare equality and inequality")
    func equalityAndInequality() throws {
        // Given
        let error1 = ARKNetworkRequestError.invalidRequest
        let error2 = ARKNetworkRequestError.error4xx(404)
        let error3 = ARKNetworkRequestError.badRequest
        let error4 = ARKNetworkRequestError.error4xx(400)

        // When & Then
        #expect(error1 == ARKNetworkRequestError.invalidRequest)
        #expect(error2 == ARKNetworkRequestError.error4xx(404))
        #expect(error3 != ARKNetworkRequestError.invalidRequest)
        #expect(error2 != error4)
    }
}
