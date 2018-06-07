import XCTest
import Snatch
@testable import SnatchOne

class JSONBodyEncodingTests: XCTestCase {
    func testJSONBodyEncoding() throws {
        let encoder = JSONBodyEncoding()

        let result = try encoder.encode(params)

        guard let string = String(data: result, encoding: .utf8) else {
            XCTFail("Should've been able to convert result data to string, data being \(result)")
            return
        }

        XCTAssert(
            expectationUno == string || expectationDuo == string,
            "Should've produced either out of 2 options."
        )
    }

    func testJSONBodyApplicationToARequest() throws {
        let encoder = JSONBodyEncoding()

        var req = URLRequest(url: whateverURL)

        try encoder.apply(params, to: &req)

        guard 
            let data = req.httpBody,
            let string = String(data: data, encoding: .utf8) 
        else {
            XCTFail("Should've been able to get the body and convert it to string, but got \(String(describing: req.httpBody))")
            return
        }

        XCTAssert(
            expectationUno == string || expectationDuo == string,
            "Should've produced either out of 2 options."
        )
    }

    let whateverURL = URL(string: "http://apple.com/genericpostroute")!

    let params = [
        "name": "Ash",
        "fame": "Trash"
    ]

    let expectationUno = "{\"name\":\"Ash\",\"fame\":\"Trash\"}"
    let expectationDuo = "{\"fame\":\"Trash\",\"name\":\"Ash\"}"

    static var allTests = [
        ("testJSONBodyEncoding", testJSONBodyEncoding),
        ("testJSONBodyApplicationToARequest", testJSONBodyApplicationToARequest),
    ]
}
