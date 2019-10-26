import XCTest
@testable import Configuration

final class ConfigurationTests: XCTestCase {
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct
    // results.
    
    let configuration: Configuration? = Configuration()
    
    XCTAssertNotNil(configuration)
  }

  static var allTests = [
      ("testExample", testExample),
  ]
}
