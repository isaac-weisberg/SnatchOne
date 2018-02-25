import XCTest
@testable import snatch

class PostTests: XCTestCase {
    func testPostModuleRequestGeneration() {
        let post = Snatch.Post()

        let req = post.generateRequest(outOf: arbitraryURL, customHeaders)

        XCTAssert(req.url == arbitraryURL, "The url should be teh saem.")
        XCTAssertNotNil(req.allHTTPHeaderFields, "The headers should be there.")
        XCTAssert(req.allHTTPHeaderFields! == customHeaders, "Headers should be the same thing.")
    }

    let customHeaders = [
        "User-agent" : "AMD286 / MS-DOS 5.0 / Chromium 32.15.133242t4",
        "Content-Type" : "useless garbage"
    ]

    let arbitraryURL = URL(string: "https://apple.com/deprecated/objectivec")!

    static var allTests = [
        ("testPostModuleRequestGeneration", testPostModuleRequestGeneration),
    ]
}