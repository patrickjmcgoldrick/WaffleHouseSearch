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
            
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else { return }
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
}
