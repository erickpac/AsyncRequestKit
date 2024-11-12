//
//  Encodable+DictionaryTests.swift
//  AsyncRequestKit
//
//  Created by epac on 12/11/24.
//

import Foundation
import Testing
@testable import AsyncRequestKit

struct ARKEncodableDictionaryTests {

    @Test("Test that a struct with valid properties is correctly converted to a dictionary")
    func asDictionary() {
        // Given
        let testStruct = TestModel(id: 1, name: "Test")

        // When
        let dictionary = testStruct.asDictionary

        // Then
        #expect(dictionary["id"] as? Int == 1)
        #expect(dictionary["name"] as? String == "Test")
    }

    @Test("Test that an empty struct is converted to an empty dictionary")
    func asDictionaryEmpty() {
        // Given
        let emptyStruct = EmptyModel()

        // When
        let dictionary = emptyStruct.asDictionary

        // Then
        #expect(dictionary.isEmpty)
    }
}
