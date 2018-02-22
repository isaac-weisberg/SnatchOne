import XCTest
@testable import snatch

class GeneralTests: XCTestCase {
    func testCommonRequestDownload() {
        let exp = expectation(description: "Should download the data and successfully resolve. WON'T if no internet connection.")

        guard let url = URL(string: "https://apple.com/") else {
            XCTFail("Should've created url to a remote source.")
            return
        }

        // TODO: utilize time intervals and cache policy. Not necessarily here, but in the project in general.
        let request = URLRequest(url: url)

        Snatch.shared.request(request)
        .then { result in
            XCTAssert(result.response.statusCode == 200, "Should be equal to 200.")
            exp.fulfill()
        }
        .catch { error in
            XCTFail("Should've not thrown")
            exp.fulfill()
        }

        waitForExpectations(timeout: 20.0)
    }

    static var allTests = [
        ("testCommonRequestDownload", testCommonRequestDownload),
    ]
}