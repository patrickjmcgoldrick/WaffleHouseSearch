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

    var mapView: GMSMapView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGoogleMap(latitude: 33.9202195, longitude: -84.5348863)
        
        if let url = encodeSearchURL() {
            readPointsFromYelp(url: url)
        }
    }
    
    /// Setup basic map parameters
    func setupGoogleMap(latitude: Double, longitude: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        mapView?.isTrafficEnabled = true
        mapView?.mapType = .hybrid
        mapView?.delegate = self
        view = mapView

    }
    
    /// Set points of Interest on the Map
    func setMarker(title: String, latitude: Double, longitude: Double) {
        
        // Create Marker
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    /// Don't encode the ''?' or the URL will be invalid
    func encodeSearchURL() -> URL? {
        // url encoding
        let encodedParams = YelpURLs.searchParams.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        guard let urlEncodedParams = encodedParams else { return nil }

        let fullURL = YelpURLs.baseSearchURL + urlEncodedParams

        return URL(string: fullURL)
    }
    
    /// Call Yelp API to the points of interest for the Map
    func readPointsFromYelp(url: URL) {
        
        let network = NetworkController()
            
        network.loadData(url: url) { (data) in
           
            print (String(bytes: data, encoding: .utf8)!)
            
            let parser = SearchParser()
            
            parser.parse(data: data) { (searchData) in
                
                guard let businesses = searchData.businesses else { return }
                
                for business in businesses {
                    
                    
                    if business.name == "Waffle House" {
                        DispatchQueue.main.async {
                            
                            /// lay down markers on Map
                            self.setMarker(title: business.name ?? "no name", latitude: business.coordinates?.latitude ?? 0.0, longitude: business.coordinates?.longitude ?? 0.0)
                        }
                    }
                }
            }
        }
    }
}

extension ViewController: GMSMapViewDelegate {
    
}

