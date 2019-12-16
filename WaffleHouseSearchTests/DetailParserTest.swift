//
//  DetailParserTest.swift
//  WaffleHouseSearchTests
//
//  Created by dirtbag on 12/15/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import XCTest
@testable import WaffleHouseSearch

class DetailParserTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDetailParser() {

        let expectation = self.expectation(description: "Testing Detail Parser")

        let testBundle = Bundle(for: type(of: self))
        let filename = "chick-fil-a_Detail"

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

            let parser = DetailParser()

            parser.parse(data: data) { (detailData) in

                print(detailData.name)
                print(detailData.hours[0].is_open_now)

                //XCTAssertTrue(tweets[0].text == "pair of dice, lost", "Unexpected Data returned")
                expectation.fulfill()
            }

        } catch {
           assertionFailure("Error: " + error.localizedDescription)
        }

        waitForExpectations(timeout: 15, handler: nil)
    }
}
