//
//  SearchData.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/9/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

struct SearchData: Codable {
    var businesses: [Business]?
}

struct Business: Codable {
    var name: String?
    var coordinates: Coordinates?
}

struct Coordinates: Codable {
    var latitude: Double?
    var longitude: Double?
}
