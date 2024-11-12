//
//  PostModel.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

struct Post: Codable {

    let id: Int
    let userId: Int
    let title: String
    let body: String
}
