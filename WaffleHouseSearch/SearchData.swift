//
//  SearchData.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/9/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//
import Foundation

// MARK: Root
struct SearchData: Codable {
    var businesses: [Business]?
    var region: Region
}

// MARK: - Business Elements
struct Business: Codable {
    var id: String
    var name: String
    var image_url: String?
    var location: Location
    var phone: String?
    var display_phone: String?
    var distance: Double?
    var rating: Double
    var review_count: Int
    var price: String?
    var is_closed: Bool
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
    var display_address: [String]
}

struct Category: Codable {
    var title: String
}

// MARK: - Region Elements
struct Region: Codable {
    var center: Coordinates
}
