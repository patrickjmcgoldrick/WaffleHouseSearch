//
//  WaffleHouseSearchTests.swift
//  WaffleHouseSearchTests
//
//  Created by dirtbag on 12/9/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import XCTest
@testable import WaffleHouseSearch

class WaffleHouseSearchTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchParser() {

        let expectation = self.expectation(description: "Testing Search Parser")

        let testBundle = Bundle(for: type(of: self))
        let filename = "waffleHouseSearch"

        let path = testBundle.path(forResource: filename, ofType: "json")
        XCTAssertNotNil(path, "\(filename) file not found")

        guard let cleanPath = path else { return }

        // convert into URL
        let url = NSURL.fileURL(withPath: cleanPath)
        do {
            // load json into Data object
            let data = try Data(contentsOf: url)

            XCTAssertNotNil(data, "Data came back nil")

            print(data.description)

            let parser = SearchParser()

            parser.parse(data: data) { (searchData) in
                for index in 0..<4 {
                    guard let isClosed = searchData.businesses?[index].is_closed
                        else { continue }
                    XCTAssertFalse(isClosed)
                }
                expectation.fulfill()
            }

        } catch {
            assertionFailure("Error: " + error.localizedDescription)
        }

        waitForExpectations(timeout: 15, handler: nil)
    }
}
