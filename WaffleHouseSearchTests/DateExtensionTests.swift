//
//  DateExtensionTests.swift
//  WaffleHouseSearchTests
//
//  Created by dirtbag on 12/15/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import XCTest
@testable import WaffleHouseSearch

class DateExtensionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateOrdinal() {
        let date = Date()
        print(date.getWeekday())
    }
    
    func testYelpOrdinal() {
        let date = Date()
        print(date.getYelpWeekday())
    }
}
