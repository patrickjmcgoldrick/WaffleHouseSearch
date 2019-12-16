//
//  ParallaxViewController.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/14/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

struct ScrollViewDataStruct {
    var title: String?
    var image: UIImage?
}

class ParallaxViewController: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView!

    var scrollViewData = [ScrollViewDataStruct]()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollViewData = [
            ScrollViewDataStruct(title: "kitten1", image: UIImage(imageLiteralResourceName: "kitten")),
            ScrollViewDataStruct(title: "kitten2", image: UIImage(imageLiteralResourceName: "kitten2")),
            ScrollViewDataStruct(title: "kitten3", image: UIImage(imageLiteralResourceName: "kitten3")),
            ScrollViewDataStruct(title: "kitten4", image: UIImage(imageLiteralResourceName: "kitten4")),
            ScrollViewDataStruct(title: "kitten5", image: UIImage(imageLiteralResourceName: "kitten5"))
        ]

        scrollView.contentSize.width = scrollView.frame.width * CGFloat(scrollViewData.count)

        for (index, data) in scrollViewData.enumerated() {
            let view = CustomView(frame: CGRect(x: 10 + scrollView.frame.width * CGFloat(index), y: 0, width: scrollView.frame.width - 20, height: scrollView.frame.height))
            view.imageView.image = data.image
            self.scrollView.addSubview(view)

        }
    }
}

class CustomView: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        assertionFailure("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iView = UIImageView()
        iView.translatesAutoresizingMaskIntoConstraints = false
        iView.backgroundColor = .darkGray
        iView.contentMode = .scaleAspectFit
        return iView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(imageView)

        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
}
