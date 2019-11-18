//
//  ConcurrencyTestTests.swift
//  ConcurrencyTestTests
//


import XCTest
@testable import ConcurrencyTest

class ConcurrencyTests: XCTestCase {
    func testloadMessage() {
        let expectation = self.expectation(description: #function)
        var result: String?
        let timeOutString = "Unable to load message - Time out exceeded"
        let actualCombineString = "Hello world"
        result = timeOutString
        loadMessage { (message) in
            result = message
            expectation.fulfill()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if expectation.expectedFulfillmentCount < 1 {
                XCTAssertEqual(result, actualCombineString, "Successfully load message")
            } else {
                XCTAssertEqual(result, timeOutString, "Time out error")
            }
        }
        waitForExpectations(timeout: 10)

    }

}
