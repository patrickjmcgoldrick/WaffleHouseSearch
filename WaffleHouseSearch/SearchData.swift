//
//  SearchData.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/9/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//
import Foundation

struct SearchData: Codable {
    var businesses: [Business]?
}

struct Business: Codable {
    var name: String
    var image_url: String?
    var location: Location
    var phone: String?
    var display_phone: String?
    var distance: Double?
    var rating: Double
    var review_count: Int
    var price: String?
    var categories: [Category]
    var coordinates: Coordinates
    
    func toMiles(meters: Double) -> String {
        let distance = Measurement(value: meters, unit: UnitLength.meters)
        let miles = distance.converted(to: .miles)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.numberFormatter.minimumFractionDigits = 1
        return formatter.string(from: miles)
    }
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
}

struct Location: Codable {
    var address1: String
}

struct Category: Codable {
    var title: String
}
