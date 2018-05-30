# Snatch

[![Maintainability](https://api.codeclimate.com/v1/badges/f56175a9f2d027469773/maintainability)](https://codeclimate.com/github/isaac-weisberg/snatch/maintainability)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Snatch is Promises meet URLSession.


## Goals

1. Provide a Promise-based wrapping around URLSession.
2. Provide an API sowewhat reminiscent of the __ECMAScript fetch API__. By "somewhat reminiscent" presumed the principle of producing promises.
3. Be usable on both Linux and Apple platforms. (Disclaimer: doesn't work on Linux platform, at least as of Swift 4.0.3 because URLSession is not entirely implemented in Foundation framework).

## Installation

#### Xcode, Apple targets

Installation with Carthage is a preferred method. Add this repository to the Cartfile, preferably some particular version, then `carthage update` and then add the resulting framework to the `carthage copy-frameworks` build phase. NOTE: when we say "resulting framework", that is actually meant, is 2 frameworks, Snatch and SnatchBase. Yeah, life ain't fair.

One could also download the binary release from the GitHub releases. If none are available, one perhaps could build from source with Carthage...

#### Swift Package Manager, Linux target

Recommended to automate the process by declaring a dependency on the project, target Snatch.

Building from source:
1. `git clone`
2. `swift package resolve`
3. `swift test`
4. `swift build -c release`

Swiftdoc and Swiftmodule will be at .build/release

Alternatively: `make release`

## Usage

Contrary to what Apple's APIs often do, Snatch __doesn't have__ it's own static `sharedInstance`, so you have to create and manage one yourself. The constructor optionally accepts a `URLSessionConfiguration` that it uses to create an underlying `URLSession` object. One `Snatch` instance = `URLSession` object.

`request(_:)` method accepts URLRequest object and initiates a `dataTask` on underlying `URLSession`, resolving upon completion of the `dataTask`, fulfilling with a Result object that contains raw response body in type `Data?` and a `HTTPURLResponse` instance, rejecting upon any clientside or connection errors. The `request(_:)` __will not__ reject upon any errornous HTTP response status codes, just like that other API, called fetch.

Result has `json(_:)` method that accepts a `Decodable` type to try to interpret the response body as. Rejects on errors, fulfills with results.

`Snatch` has 2 shortcut modules built in, `get` and `post` which allow for shortcut assembly of GET and POST requests thorough their redefined `subscript` values. Custom headers are supported for both options. Arbitrary encodable is supported for `post` request, which will be ALWAYS encoded as JSON. Unescaped basic URLQuery assembly is supported for `get`.

## Samples

Basic GET with parameters and headers:
```swift
let snatch: Snatch = Snatch()
let url = URL(string: "https://apple.com")!
let params = ["objective-c-runtime": "penis"]
let headers = ["User-Agent":"70 years old Casio calculator"]

snatch.get[ url, params, headers ].then { res in
    res.data // body of response
}.catch { err in

}
```

Generic whatever request
```swift
let snatch: Snatch = Snatch()
let url = URL(string: "https://apple.com")!
var request = URLRequest(url: url)

// Do whatever you want to do with `request`
// request.httpMethod = "GAY"

snatch.request(request).then { res in
    res.data // body of response
}.catch { err in

}
```
