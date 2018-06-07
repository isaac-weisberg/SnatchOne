import XCTest
import Foundation
@testable import Snatch

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

    func testPayloadThatWouldntBeParsed() {
        let response = goodResponse
        let failishData = "savhnqeirhg9qrg5ouh345uhq24-85gh-    1348tg4-g3".data(using: .utf8)!
        let result = Result(from: response, failishData)

        let exp = expectation(description: "Should reject cause body is gibberish")

        result.json(ResultTargetType.self).then { user in
            XCTFail("Should've rejected cause the body is supposed to be garbage.")
        }.catch { err in
            XCTAssertFalse(err is Result.NoBodyError, "Should've not even been NoBodyError")
        }.always {
            exp.fulfill()
        }

        waitForExpectations(timeout: 20.0)
    }


    static var allTests = [
        ("testValidJSONPayload", testValidJSONPayload),
        ("testNoPayloadDecoding", testNoPayloadDecoding),
        ("testPayloadThatWouldntBeParsed", testPayloadThatWouldntBeParsed),
    ]
}