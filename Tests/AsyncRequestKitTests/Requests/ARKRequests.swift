//
//  ARKRequests.swift
//  AsyncRequestKit
//
//  Created by epac on 11/11/24.
//

@testable import AsyncRequestKit

struct ARKRequests {

    static let postsPath = "/posts"

    struct GetPosts: ARKRequest {
        typealias ReturnType = [Post]
        var path: String { ARKRequests.postsPath }
    }

    struct GetPost: ARKRequest {
        typealias ReturnType = Post
        var path: String

        init(id: Int) {
            self.path = "\(ARKRequests.postsPath)/\(id)"
        }
    }

    struct AddPost: ARKRequest {
        typealias ReturnType = Post
        var path: String { ARKRequests.postsPath }
        var method: ARKHTTPMethod { .post }
        var body: ARKHTTPParams

        init(post: Post) {
            self.body = post.asDictionary
        }
    }

    struct UpdatePost: ARKRequest {
        typealias ReturnType = Post
        var path: String
        var method: ARKHTTPMethod { .put }
        var body: ARKHTTPParams

        init(post: Post) {
            self.path = "\(ARKRequests.postsPath)/\(post.id)"
            self.body = post.asDictionary
        }
    }

    struct DeletePost: ARKRequest {
        typealias ReturnType = Post
        var path: String
        var method: ARKHTTPMethod { .delete }

        init(id: Int) {
            self.path = "\(ARKRequests.postsPath)/\(id)"
        }
    }
}
