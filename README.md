# AsyncRequestKit

`AsyncRequestKit` is a Swift Package that simplifies making network requests with async/await. It provides an easy-to-use, lightweight library for performing asynchronous network calls in Swift.

## Features

- **Asynchronous Networking**: Perform network requests with async/await for a modern Swift concurrency experience.
- **Lightweight Design**: Minimal dependencies and optimized for performance.
- **Customizable**: Easily configurable for different request types and headers.
- **Error Handling**: Robust error handling for networking issues.

## Requirements

- **Swift**: 5.5 or later
- **Platforms**: iOS 15.0+
- **Xcode**: 13.0 or later

## Installation

To integrate `AsyncRequestKit` into your project, use Swift Package Manager:

1. Open your project in Xcode.
2. Go to **File > Add Packages**.
3. Enter the repository URL for `AsyncRequestKit`.
4. Select the version and add the package.

Alternatively, add the following line to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/AsyncRequestKit", from: "1.0.0")
]
```

## Usage

```swift
import AsyncRequestKit

/// GET request example
struct Posts: ARKRequest {

    typealias ReturnType = [Post]
    var path: String = "/posts"
}

/// POST request example
struct AddPost: ARKRequest {

    typealias ReturnType = Post
    var path: String = "/post"
    var method: ARKHTTPMethod = .post

    init (post: Post) {
        body = post.asDictionary
    }
}

/// DELETE request example
struct DeletePost: ARKRequest {

    typealias ReturnType = Empty
    var path: String
    var method: ARKHTTPMethod = .delete

    init(id: Int) {
        path = "/post/\(id)"
    }
}

struct APIManagerProvider {

    let apiClient = ARKAPIClient(baseURL: "https://yoururl.com")

    func fetchPosts() async {
        do {
            let result = try await apiClient.dispatch(Posts())
        } catch {
            print(error)
        }
    }
}
```

## License

`AsyncRequestKit` is available under the MIT license. See the [LICENSE](LICENSE) file for more information.

## Credits

This project was inspired by the work in [WireKit](https://github.com/afterxleep/WireKit). Special thanks to the contributors of that project for their ideas and guidance.
