//
//  SearchParser.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/9/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//
import Foundation

class SearchParser {

    func parse(data: Data, parsed: @escaping (SearchData) -> Void) {

        // create decoder
        let jsonDecoder = JSONDecoder()
        
        do {
            // decode json into structs
            let searchData = try jsonDecoder.decode(SearchData.self, from: data)

            parsed(searchData)

        } catch {
            print("Error Parsing SearchData from JSON: \(error.localizedDescription)")
        }
        
    }
}
