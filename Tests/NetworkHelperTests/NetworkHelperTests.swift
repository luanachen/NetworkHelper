import XCTest
@testable import NetworkHelper

final class NetworkHelperTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NetworkHelper().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
