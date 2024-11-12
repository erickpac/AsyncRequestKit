//
//  Encodable+Dictionary.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

import Foundation

public extension Encodable {

    var asDictionary: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dictionary
    }

}
