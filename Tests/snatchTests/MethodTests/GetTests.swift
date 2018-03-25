import XCTest
@testable import snatch

class GetTests: XCTestCase {
    func testGetDownload() {
        let exp = expectation(description: "Should download the data and successfully resolve. WON'T if no internet connection.")

        guard let url = URL(string: "https://apple.com/") else {
            XCTFail("Should've created url to a remote source.")
            return
        }
        
        Snatch.shared.get[ url ]
        .then { result in
            XCTAssert(result.response.statusCode == 200, "Should be equal to 200.")
        }
        .catch { error in
            XCTFail("Should've not thrown \(error)")
        }.always {
            exp.fulfill()
        }

        waitForExpectations(timeout: 20.0)
    }

    func testURLRequestCreation() {
        guard let url = URL(string: "https://apple.com/") else {
            XCTFail("Should've created url to a remote source.")
            return
        }

        let req = URLRequest(url: url)

        XCTAssert(req.httpMethod == "GET", "Should be get by default")
    }

    func testHeadersApplication() {
        let exp = expectation(description: "Should at least try to download")

        guard let url = URL(string: "https://apple.com/") else {
            XCTFail("Should've created url to a remote source.")
            return
        }

        let params = [
            "id": "3",
            "people": "sodds"
        ]

        Snatch.shared.get[ url, params, customHeaders ].always {
            exp.fulfill()
        }

        waitForExpectations(timeout: 20.0)
    }

    /*
        There should be a test of a request with URLEncoded parameters, but you know an echo website? cuz I don't
        so i can't really think of how am I supposed to test it out...
    */

    let customHeaders = [
        "User-agent" : "AMD286 / MS-DOS 5.0 / Chromium 32.15.133242t4",
        "Content-Type" : "useless garbage"
    ]

    static var allTests = [
        ("testGetDownload", testGetDownload),
        ("testURLRequestCreation", testURLRequestCreation),
        ("testHeadersApplication", testHeadersApplication),
    ]
}
