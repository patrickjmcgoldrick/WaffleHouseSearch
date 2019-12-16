//
//  YelpSearchViewController.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/13/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit

class YelpSearchViewController: UIViewController {

    @IBOutlet weak var searchView: UISearchBar!
    
    @IBOutlet weak var tfLocation: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var businessesFound = [Business]()
    var searchCoordinates = Coordinates(latitude: 33.9202195, longitude: -84.5348863)
    let yelpSearcher = YelpSearcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToMapSegue" {
            if let destination = segue.destination as? ViewController {
                destination.businessesFound = businessesFound
                destination.searchedCoordinates = searchCoordinates
            }
        } else if segue.identifier == "searchToDetailSegue" {
            if let destination = segue.destination as? DetailViewController {
                
                guard let index = tableView.indexPathForSelectedRow?.row else { return }
                destination.business = businessesFound[index]
            }
        }
    }
}

// MARK: -  Search Controller
extension YelpSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count >= 3 {
            
            var url: URL?
            
            if let location = tfLocation.text {
                if tfLocation.text == "" {
                    url = yelpSearcher.createURL(searchTerm: searchText,
                                       latitude: searchCoordinates.latitude,
                                       longitude: searchCoordinates.longitude)
                } else {
                    url = yelpSearcher.createURL(searchTerm: searchText, location: location)
                }
            }
            
            guard let unrappedURL = url else { return }
            
            searchYelp(url: unrappedURL)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        
        performSegue(withIdentifier: "searchToMapSegue", sender: self)
    }
    
    private func searchYelp(url: URL) {
            
        yelpSearcher.readPointsFromYelp(url: url) { (searchData) in
            
            guard let businesses = searchData.businesses else { return }
            
            self.businessesFound = businesses
            self.searchCoordinates = searchData.region.center
            
            DispatchQueue.main.async {

                self.tableView.reloadData()
            }
        }
        
    }
}

// MARK: Table DataSource
extension YelpSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businessesFound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "SearchCell")
        
        let business = businessesFound[indexPath.row]
        cell.textLabel?.text = business.name
        if let distance = business.distance {
            cell.detailTextLabel?.text = business.toMiles(meters: distance)
        }
        
        return cell
    }
}

// MARK: Table Delegate
extension YelpSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "searchToDetailSegue", sender: self)
        print("index: \(indexPath.row)")
    }
}
