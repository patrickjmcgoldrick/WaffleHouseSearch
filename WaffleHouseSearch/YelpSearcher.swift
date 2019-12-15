//
//  YelpSearcher.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/13/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

class YelpSearcher {
    
    /// Call Yelp API to the points of interest for the Map
    func readPointsFromYelp(url: URL, found: @escaping (([Business]) -> Void)) {
        
        let network = NetworkController()
            
        network.loadData(url: url) { (data) in
                       
            let parser = SearchParser()
            
            parser.parse(data: data) { (searchData) in
                
                guard let businesses = searchData.businesses else { return }
                
                found(businesses)
            }
        }
    }
    
    /// Note: Don't encode the ''?' or the URL will be invalid
    func encodeURL(searchTerm: String) -> URL? {
        // url encoding
        let paramString = YelpURLs.searchParamsTerm + searchTerm + YelpURLs.searchParamsPosition
        let encodedParams = paramString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        guard let urlEncodedParams = encodedParams else { return nil }

        let fullURL = YelpURLs.baseSearchURL + urlEncodedParams

        return URL(string: fullURL)
    }
    

}
