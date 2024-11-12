//
//  ARKHTTPMethodTests.swift
//  AsyncRequestKit
//
//  Created by epac on 12/11/24.
//

import Testing
@testable import AsyncRequestKit

struct ARKHTTPMethodTests {

    @Test("ARKHTTPMethod raw values should match HTTP method strings", arguments: ARKHTTPMethod.allCases)
    func checkARKHTTPMethodRawValues(method: ARKHTTPMethod) throws {
        // Given
        let expectedRawValue: String
        switch method {
        case .get:
            expectedRawValue = "GET"
        case .post:
            expectedRawValue = "POST"
        case .put:
            expectedRawValue = "PUT"
        case .delete:
            expectedRawValue = "DELETE"
        case .patch:
            expectedRawValue = "PATCH"
        }

        // When
        let actualRawValue = method.rawValue

        // Then
        #expect(actualRawValue == expectedRawValue)
    }

    @Test("ARKHTTPMethod should conform to CaseIterable")
    func testARKHTTPMethodConformanceToCaseIterable() throws {
        // Given
        let methods = ARKHTTPMethod.allCases
        
        // When
        let containsGet = methods.contains(.get)
        let containsPost = methods.contains(.post)
        let containsPut = methods.contains(.put)
        let containsDelete = methods.contains(.delete)
        let containsPatch = methods.contains(.patch)
        
        // Then
        #expect(containsGet)
        #expect(containsPost)
        #expect(containsPut)
        #expect(containsDelete)
        #expect(containsPatch)
    }
}
