//
//  Encodable+Dictionary.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

import Foundation

public extension Encodable {

    /// Converts the conforming `Encodable` object to a dictionary representation.
    ///
    /// This computed property attempts to encode the object into JSON data and then
    /// deserialize that data into a dictionary. If either operation fails, it returns
    /// an empty dictionary.
    ///
    /// - Returns: A dictionary representation of the object, or an empty dictionary if encoding or deserialization fails.
    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }
}
