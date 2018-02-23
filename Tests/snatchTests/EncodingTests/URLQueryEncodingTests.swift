import XCTest
@testable import snatch

class URLQueryEncodingTests: XCTestCase {
    func testURLEncoding() {
        let encoding = URLQueryEncoding()

        let dict = [
            "name": "Peter",
            "lastname": "Jackson"
        ]

        let expectation = "name=Peter&lastname=Jackson"

        let result = encoding.encode(dict)
        XCTAssert(expectation == result, "Should produce a valid encoding of the dictionary, but got this \(result)")
    }

    static var allTests = [
        ("testURLEncoding", testURLEncoding),
    ]
}
