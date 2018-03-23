import XCTest
@testable import snatch

class PostTests: XCTestCase {
    func testPostModuleRequestGeneration() {
        let post = Snatch.Post()

        let req = post.generateRequest(outOf: arbitraryURL, customHeaders)

        XCTAssert(req.url == arbitraryURL, "The url should be teh saem.")
        XCTAssertNotNil(req.allHTTPHeaderFields, "The headers should be there.")
        print(req.allHTTPHeaderFields)
        XCTAssert(req.allHTTPHeaderFields! == customHeaders, "Headers should be the same thing.")
    }
    
    func testPostWithHeaders() {
        let exp = //expectation(description: "Should work")
        
        let snatch = Snatch()
        snatch.post[ arbitraryURL, ["fuck": 3, "faffing": "over 9000"], customHeaders ].then { res in
            exp.fulfill()
        }.catch { error in
            XCTFail("\(error)")
        }.always {
            print("done")
        }
        
        waitForExpectations(timeout: 20.0)
    }

    let customHeaders = [
        "User-agent" : "AMD286 / MS-DOS 5.0 / Chromium 32.15.133242t4",
        "Content-Type" : "useless garbage"
    ]

    let arbitraryURL = URL(string: "https://apple.com/deprecated/objectivec")!

    static var allTests = [
        ("testPostModuleRequestGeneration", testPostModuleRequestGeneration),
        ("testPostWithHeaders", testPostWithHeaders),
    ]
}
