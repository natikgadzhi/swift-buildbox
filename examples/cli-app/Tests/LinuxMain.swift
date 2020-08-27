import XCTest

import cli_appTests

var tests = [XCTestCaseEntry]()
tests += cli_appTests.allTests()
XCTMain(tests)
