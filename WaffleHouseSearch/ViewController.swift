//
//  ViewController.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/9/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    var mapView: GMSMapView?
    
    var searchedCoordinates: Coordinates?
    var businessesFound: [Business]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let coordinates = searchedCoordinates else { return }
        
        setupGoogleMap(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
        
        // setup map points
        guard let businesses = businessesFound else { return }
        for business in businesses {
            
            let milesString = business.toMiles(meters: business.distance ?? 0.0)
            setMarker(title: business.name,
                      distance: milesString,
                      latitude: business.coordinates.latitude,
                      longitude: business.coordinates.longitude)
        }
    }
    
    /// Setup basic map parameters
    func setupGoogleMap(latitude: Double, longitude: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        //mapView?.isTrafficEnabled = true
        mapView?.mapType = .normal
        mapView?.isMyLocationEnabled = true
        mapView?.delegate = self
        view = mapView
    }
    
    /// Set points of Interest on the Map
    func setMarker(title: String, distance: String, latitude: Double, longitude: Double) {
        
        // Create Marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.snippet = distance
        marker.map = mapView
    }
    


}

extension ViewController: GMSMapViewDelegate {
    
}

