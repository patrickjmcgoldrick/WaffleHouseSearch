//
//  NetworkController.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/9/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

class NetworkController {

    func loadData(url: URL, completed: @escaping (Data) -> Void) {

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(YelpAPI.authorizationKey, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in

            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }

            completed(data)
        }
        task.resume()
    }
}
