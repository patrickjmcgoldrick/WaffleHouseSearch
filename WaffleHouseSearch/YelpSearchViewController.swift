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
        }
    }
}

// MARK: -  Search Controller
extension YelpSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count >= 3 {

            searchYelp(searchTerm: searchText)
        }

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        /*
        guard let searchTerm = searchBar.text else { return }
        
        if searchTerm.count < 2
            && searchTerm.count > 0 {
            
            searchYelp(searchTerm: searchTerm)
        }
        */
        view.endEditing(true)
        
        performSegue(withIdentifier: "searchToMapSegue", sender: self)
    }
    
    private func searchYelp(searchTerm: String) {

        if let url = yelpSearcher.encodeURL(searchTerm: searchTerm) {
            
            yelpSearcher.readPointsFromYelp(url: url) { (businesses) in
                
                self.businessesFound = businesses
                
                DispatchQueue.main.async {

                    self.tableView.reloadData()
                }
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
        
        cell.textLabel?.text = businessesFound[indexPath.row].name
        let distance = Measurement(value: businessesFound[indexPath.row].distance ?? 0, unit: UnitLength.meters)
        let miles = distance.converted(to: .miles)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.numberFormatter.minimumFractionDigits = 1
        cell.detailTextLabel?.text = formatter.string(from: miles)
        
        return cell
    }
}

// MARK: Table Delegate
extension YelpSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
