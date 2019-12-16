//
//  ImageTableViewCell.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/14/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var parallaxImage: UIImageView!

    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var parallaxHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var parallaxTopConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()

        parallaxImage.clipsToBounds = true
    }

    func configureCell(title: String, image: UIImage) {
        parallaxImage.image = image
        lblTitle.text = title
    }

}
