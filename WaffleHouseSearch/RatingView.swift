//
//  RatingView.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/15/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class RatingView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var imageStar0: UIImageView!
    
    @IBOutlet weak var imageStar1: UIImageView!
    
    @IBOutlet weak var imageStar2: UIImageView!
    
    @IBOutlet weak var imageStar3: UIImageView!
    
    @IBOutlet weak var imageStar4: UIImageView!
    
    var rating: Double = 0.0 {
        didSet {
            let roundedRating = Int(rating.rounded())
            for index in 0..<stars.count {
                if index < roundedRating {
                    stars[index].image = redStar
                } else {
                    stars[index].image = grayStar
                }
            }
        }
    }
    
    var stars = [UIImageView]()
    let redStar = UIImage(imageLiteralResourceName: "star")
    let grayStar = UIImage(imageLiteralResourceName: "starGray")
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         commonInit()
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         commonInit()
     }
     
     private func commonInit() {
         
         Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)
         addSubview(contentView)
         contentView.frame = bounds
         contentView.autoresizingMask = [] //[.flexibleHeight, .flexibleWidth]
        
        stars.append(imageStar0)
        stars.append(imageStar1)
        stars.append(imageStar2)
        stars.append(imageStar3)
        stars.append(imageStar4)
     }
    
    
    
    
}
