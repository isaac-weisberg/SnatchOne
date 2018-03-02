import XCTest
@testable import snatchTests

XCTMain([
    testCase(GeneralTests.allTests),
    testCase(GetTests.allTests),
    testCase(PostTests.allTests),
    testCase(URLQueryEncodingTests.allTests),
    testCase(JSONBodyEncodingTests.allTests),
    testCase(JSONDecodingForResultTests.allTests),
])
