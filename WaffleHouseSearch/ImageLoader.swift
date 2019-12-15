//
//  ImageLoader.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/15/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class ImageLoader {
    
    func loadImage(urlString: String, imageView: UIImageView) {

        if let url = URL(string: urlString) {
            
            let network = NetworkController()

            network.loadData(url: url, completed: { (data) in

                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            })
        }
    }    
}
