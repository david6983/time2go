//
//  time2goTests.swift
//  time2goTests
//
//  Created by david6983 on 14/06/2022.
//

import XCTest
@testable import time2go

class time2goTests: XCTestCase {
    func testGetAfternoonOut() throws {
        let view = ContentView()
        view.morningIn = Calendar.current.date(from: DateComponents(hour: 8, minute: 0))!
        view.morningOut = Calendar.current.date(from: DateComponents(hour: 12, minute: 0))!
        view.afternoonIn = Calendar.current.date(from: DateComponents(hour: 13, minute: 0))!
        let afternoonOut = view.getAfternoonOut()
        let expectedAfternoonOut = Calendar.current.date(from: DateComponents(hour: 17, minute: 31))
        XCTAssertEqual(afternoonOut, expectedAfternoonOut)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
}
