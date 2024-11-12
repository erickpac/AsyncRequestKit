//
//  Requests.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

@testable import AsyncRequestKit

struct GetPostsRequest: ARKRequest {

    typealias ReturnType = [Post]
    var path: String { "/posts" }
}

struct GetPostRequest: ARKRequest {

    typealias ReturnType = Post
    var path: String

    init(id: Int) {
        path = "/posts/\(id)"
    }
}

struct AddPostRequest: ARKRequest {

    typealias ReturnType = Post
    var path: String { "/posts" }
    var method: ARKHTTPMethod { .post }
    var body: ARKHTTPParams

    init(post: Post) {
        body = post.asDictionary
    }
}

struct UpdatePostRequest: ARKRequest {

    typealias ReturnType = Post
    var path: String
    var method: ARKHTTPMethod { .put }
    var body: ARKHTTPParams
    
    init(post: Post, id: Int) {
        path = "/posts/\(id)"
        body = post.asDictionary
    }
}

struct DeletePostRequest: ARKRequest {

    typealias ReturnType = Post
    var path: String
    var method: ARKHTTPMethod { .delete }

    init(post: Post) {
        path = "/posts/\(post.id)"
    }
}
