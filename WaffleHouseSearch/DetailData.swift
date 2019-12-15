//
//  DetailData.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/15/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

struct DetailData: Codable {
    var name: String
    var hours: [Hours]
}

struct Hours: Codable {
    var open: [Day]
    var is_open_now: Bool
    var hours_type: String
}

struct Day: Codable {
    var day: Int
    var start: String
    var end: String
    var is_overnight: Bool
}
