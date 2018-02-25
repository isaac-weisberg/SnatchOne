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
        let anotherExpectation = "lastname=Jackson&name=Peter"

        let result = encoding.encode(dict)
        XCTAssert(expectation == result || anotherExpectation == result, "Should produce a valid encoding of the dictionary, but got this \(result)")
    }

    func testURLEncodingQuerySwap() {
        let encoding = URLQueryEncoding()
        
        let baseUrl = URL(string: "https://apple.com/shitlang?objectivec=yes")!

        let newQuery = "name=Peter&lastname=Jackson"

        let expectation = "https://apple.com/shitlang?name=Peter&lastname=Jackson"

        guard let newUrl = encoding.swapQuery(of: baseUrl, with: newQuery) else {
            XCTFail("Should've successfully created new url")
            return
        }

        XCTAssert(newUrl.absoluteString == expectation, "Should've successfully swapped query for a new one, but instead resulted in \(newUrl.absoluteString)")
    }

    func testURLEncodingQuerySwapButWithParametersArray() {
        let encoding = URLQueryEncoding()
        
        let baseUrl = URL(string: "https://apple.com/shitlang?objectivec=yes")!

        let params = [
            "name": "Peter",
            "lastname": "Jackson"
        ]

        let expectation = "https://apple.com/shitlang?name=Peter&lastname=Jackson"

        guard let newUrl = encoding.swapQuery(of: baseUrl, with: params) else {
            XCTFail("Should've successfully created new url")
            return
        }

        XCTAssert(newUrl.absoluteString == expectation, "Should've successfully swapped query for a new one constructed out of the params we given, but instead resulted in \(newUrl.absoluteString)")
    }

    static var allTests = [
        ("testURLEncoding", testURLEncoding),
        ("testURLEncodingQuerySwap", testURLEncodingQuerySwap),
    ]
}
