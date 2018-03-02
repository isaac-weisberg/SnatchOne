import XCTest
import Foundation
@testable import snatch

class JSONDecodingForResultTests: XCTestCase {
    class ResultTargetType: Decodable {
        var name: String
        var lastName: String
    }

    let goodData: Data = """
{
    "name": "John",
    "lastName": "Fucks"
}
""".data(using: .utf8)!

    lazy var goodResponse = HTTPURLResponse(url: genericURL, statusCode: 200, httpVersion: nil, headerFields: nil)!

    let genericURL = URL(string: "https://apple.com/someresource")!

    func testValidJSONPayload() {
        let response = goodResponse
        let data = goodData

        let result = Result(from: response, data)
        
        let exp = expectation(description: "Should successfully fulfill with parsed object")

        result.json(ResultTargetType.self).then { user in
            XCTAssert(user.name == "John", "Should be called John")
            XCTAssert(user.lastName == "Fucks", "Last name should be the same")
        }.catch { err in
            XCTFail("Should've fullfilled with no problems.")
        }.always {
            exp.fulfill()
        }

        waitForExpectations(timeout: 20.0)
    }

    func testNoPayloadDecoding() {
        let response = goodResponse
        let result = Result(from: response, nil)

        let exp = expectation(description: "Should reject cause body nil")

        result.json(ResultTargetType.self).then { user in
            XCTFail("Should've rejected cause no body.")
        }.catch { err in
            XCTAssert(err is Result.NoBodyError, "Should've thrown NoBodyError")
        }.always {
            exp.fulfill()
        }

        waitForExpectations(timeout: 20.0)
    }


    static var allTests = [
        ("testValidJSONPayload", testValidJSONPayload),
        ("testNoPayloadDecoding", testNoPayloadDecoding),
    ]
}