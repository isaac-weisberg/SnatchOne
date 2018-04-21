import XCTest
@testable import Snatch

extension PostTests {
    internal class CustomPieceOfData: Encodable {
        let name: String
        let age: Int

        init(_ name: String, _ age: Int) {
            self.name = name
            self.age = age
        }
    }
}

class PostTests: XCTestCase {
    func testPostModuleRequestGeneration() {
        let post = Snatch.Post()

        let req = post.generateRequest(outOf: arbitraryURL, customHeaders)

        XCTAssert(req.url == arbitraryURL, "The url should be teh saem.")
        XCTAssertNotNil(req.allHTTPHeaderFields, "The headers should be there.")
        XCTAssert(req.allHTTPHeaderFields! == customHeaders, "Headers should be the same thing.")
    }
    
    func testPostWithHeaders() {
        let exp = expectation(description: "Should at very least call the method and successfully complete.")
        
        let snatch = Snatch()

        let params = CustomPieceOfData("Jackie", 24)

        snatch.post[ arbitraryURL, params, customHeaders ].always {
            exp.fulfill()
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
