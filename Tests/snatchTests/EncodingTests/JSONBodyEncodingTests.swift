import XCTest
@testable import snatch

class JSONBodyEncodingTests: XCTestCase {
    func testJSONBodyEncoding() throws {
        let encoder = JSONBodyEncoding()

        let params = [
            "name": "Ash",
            "fame": "Trash"
        ]

        let expectationUno = "{\"name\":\"Ash\",\"fame\":\"Trash\"}" 
        let expectationDuo = "{\"fame\":\"Trash\",\"name\":\"Ash\"}" 

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

    static var allTests = [
        ("testJSONBodyEncoding", testJSONBodyEncoding),
    ]
}