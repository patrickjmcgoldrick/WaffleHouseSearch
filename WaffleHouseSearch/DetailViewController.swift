//
//  YelpDetailViewController.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/15/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblReviews: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblNotPrice: UILabel!
    
    @IBOutlet weak var lblFoodType: UILabel!
    
    @IBOutlet weak var lblIsClosed: UILabel!
    
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavbar()
        setupBusinessData()
        
    }
    
    func setupBusinessData() {
        if let imageURL = business?.image_url {
            let imageLoader = ImageLoader()

            imageLoader.loadImage(urlString: imageURL, imageView: imageView)
        }

        lblName.text = business?.name
        if let reviews = business?.review_count {
            lblReviews.text = "\(reviews) Reviews"
        }
        
        // Price $'s
        if let price = business?.price {
            let notPriceCount = 4 - price.count
            lblPrice.text = price
            var notPrice = ""
            for index in 0..<notPriceCount {
                notPrice += "$"
            }
            lblNotPrice.text = notPrice
        }
        
        // Categories
        if let categories = business?.categories {
            var categoryString = ""
            for (index, category) in categories.enumerated() {
                if index == 0 {
                    categoryString += category.title
                } else {
                    categoryString += ", " + category.title
                }
            }
            lblFoodType.text = categoryString
        }
        
        // is Close or Open
        if let isClosed = business?.is_closed {
            if isClosed == true {
                lblIsClosed.text = "Closed"
                lblIsClosed.textColor = .systemRed
            } else {
                lblIsClosed.text = "Open"
                lblIsClosed.textColor = .systemGreen
            }
        }
    }
    
    func transparentNavbar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.backItem?.backBarButtonItem?.title = "Search"
        navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = .white
    }
    


}
