//
//  ParallaxVerticalViewController.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/14/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class ParallaxVerticalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var scrollViewData = [
        ScrollViewDataStruct(title: "kitten0", image: UIImage(imageLiteralResourceName: "kitten0")),
        ScrollViewDataStruct(title: "kitten1", image: UIImage(imageLiteralResourceName: "kitten1")),
        ScrollViewDataStruct(title: "kitten2", image: UIImage(imageLiteralResourceName: "kitten2")),
        ScrollViewDataStruct(title: "kitten3", image: UIImage(imageLiteralResourceName: "kitten3")),
        ScrollViewDataStruct(title: "kitten4", image: UIImage(imageLiteralResourceName: "kitten4"))
    ]

    var parallaxOffsetSpeed: CGFloat = 30
    var cellHeight: CGFloat = 180

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

    }

    var parallaxImageHeight: CGFloat {

        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * self.tableView.frame.height) - cellHeight) / 2
        return maxOffset + cellHeight
    }

    func parallaxOffset(newOffsetY: CGFloat, cell: UITableViewCell) -> CGFloat {

        return (newOffsetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffsetSpeed
    }
}

// MARK: TableView Data Source
extension ParallaxVerticalViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return scrollViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ParallaxCell") as? ImageTableViewCell
            else { return UITableViewCell() }

        if let image = scrollViewData[indexPath.row].image, let title = scrollViewData[indexPath.row].title {

            cell.configureCell(title: title, image: image)
            cell.parallaxHeightConstraint.constant = self.parallaxImageHeight
            cell.parallaxTopConstraint.constant = parallaxOffset(newOffsetY: tableView.contentOffset.y, cell: cell)

        }
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("did scroll")
        let offsetY = tableView.contentOffset.y
        guard let visibleCells = tableView.visibleCells as? [ImageTableViewCell]  else { return }
        for cell in visibleCells {
            //guard let cell = cell else { continue }
            cell.parallaxTopConstraint.constant = parallaxOffset(newOffsetY: offsetY, cell: cell)
        }
    }
}

// MARK: TableView Delegate
extension ParallaxVerticalViewController: UITableViewDelegate {

}
