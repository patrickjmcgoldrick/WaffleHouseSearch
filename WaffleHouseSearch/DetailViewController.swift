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
    
    @IBOutlet weak var ratingView: RatingView!
    
    @IBOutlet weak var lblHours: UILabel!
    
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    var business: Business?
    var details: DetailData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transparentNavbar()
        setupBusinessData()
        
        if details == nil {
            // this happens if user skips the map
            //  and goes directly to details
            loadDetails()
        } else {
            setupDetailData()
        }
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
        
        // set rating value in UI
        if let rating = business?.rating {
            ratingView.rating = rating
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
        
        // phone info
        if let phone = business?.display_phone {
            lblPhone.text = phone
        } else {
            lblPhone.text = ""
        }
        
        if let address = business?.location.display_address {
            var addressString = ""
            for line in address {
                addressString += line + "\n"
            }
            lblAddress.text = addressString
        }
    }
    
    func setupDetailData() {
        // is business open or closed?
         if let isNowOpen = details?.hours[0].is_open_now,
             let hourData = details?.hours[0].open {
             let todayHours = hoursToday(days: hourData)
             if todayHours.count == 0 {
                 lblIsClosed.text = "Closed Today"
                 lblIsClosed.textColor = .systemRed
                 lblHours.text = ""
             } else {
                 
                 if isNowOpen {
                     lblIsClosed.text = "Open"
                     lblIsClosed.textColor = .systemGreen
                } else {
                     lblIsClosed.text = "Closed"
                     lblIsClosed.textColor = .systemRed
                 }
                // format today's hours
                let formattedHours = formatTimeData(start: todayHours[0].start, end: todayHours[0].end)
                lblHours.text = formattedHours
             }
         }
    }
    
    func loadDetails() {
        if let id = business?.id {
            
            let searcher = YelpSearcher()
            searcher.readDetails(id: id) { (detailData) in
                self.details = detailData
                
                DispatchQueue.main.async {
                    self.setupDetailData()
                }
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
    
    private func hoursToday(days: [Day]) -> [Day] {
        let yelpWeekday = Date().getYelpWeekday()
        var resultDays = [Day]()
        for day in days {
            if day.day == yelpWeekday {
                resultDays.append(day)
            }
        }
        return resultDays
    }
    
    private func formatTimeData(start: String, end: String) -> String {
        
        guard let startHour = Int(start.prefix(2)) else { return "" }
        guard let endHour = Int(end.prefix(2)) else { return "" }
        guard let startMinutes = Int(start.suffix(2)) else { return "" }
        guard let endMinutes = Int(end.suffix(2)) else { return "" }
        
        return formatHour(hour: startHour, minutes: startMinutes)
            + " - " + formatHour(hour: endHour, minutes: endMinutes)
    }
    
    private func isPM(hour: Int) -> Bool {
        if hour > 11 {
            return true
        }
        return false
    }
    
    private func formatHour(hour: Int, minutes: Int) -> String {
        var resultString = ""
        let pm = isPM(hour: hour)
        if pm {
            resultString = "\(hour - 12)"
            if minutes != 0 {
                resultString += ":" + String(minutes)
            } else {
                resultString += ":00"
            }
            resultString += "PM"
        } else {
            resultString = String(hour)
            if minutes != 0 {
                resultString += ":" + String(minutes)
            } else {
                resultString += ":00"
            }
            resultString += "AM"
        }
            
        return resultString
    }
}
