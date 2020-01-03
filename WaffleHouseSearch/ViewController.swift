//
//  ViewController.swift
//  WaffleHouseSearch
//
//  Created by dirtbag on 12/9/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import UIKit
import YelpHelper
import GoogleMaps

class ViewController: UIViewController {

    var mapView: GMSMapView?

    var searchedCoordinates: Coordinates?
    var businessesFound: [Business]?
    var selectedBusiness: Business?
    var selectedDetails: DetailData?
    var markerToBusiness = [GMSMarker: Business]()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let coordinates = searchedCoordinates else { return }

        // make navbar transparent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .darkGray

        navigationController?.navigationBar.alpha = 0.5
        navigationController?.navigationBar.tintColor = .black

        navigationController?.navigationBar.backgroundColor = .lightGray

        setupGoogleMap(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)

        // setup map points
        guard let businesses = businessesFound else { return }
        for business in businesses {

            let milesString = business.toMiles(meters: business.distance ?? 0.0)
            let position = CLLocationCoordinate2D(latitude: business.coordinates.latitude, longitude: business.coordinates.longitude)

            // set marker
            let marker = setMarker(title: business.name,
                                   distance: milesString,
                                   position: position)

            // put business in dictionary
            markerToBusiness[marker] = business
        }
    }

    /// Setup basic map parameters
    func setupGoogleMap(latitude: Double, longitude: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        mapView?.mapType = .normal
        mapView?.isMyLocationEnabled = true
        mapView?.delegate = self
        view = mapView
    }

    /// Set points of Interest on the Map
    func setMarker(title: String, distance: String,
                   position: CLLocationCoordinate2D) -> GMSMarker {

        // Create Marker
        let marker = GMSMarker()
        marker.position = position
        marker.title = title
        marker.snippet = distance
        marker.map = mapView

        return marker
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "mapToDetailSegue" {

            guard let destination = segue.destination as? DetailViewController
                else { return }

            destination.business = selectedBusiness
            destination.details = selectedDetails
        }
    }
}

extension ViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        selectedBusiness = markerToBusiness[marker]

        if let id = selectedBusiness?.id {

            let searcher = YelpSearcher(apiKey: YelpAPI.authorizationKey)
            searcher.readDetails(id: id) { (detailData) in
                self.selectedDetails = detailData

                DispatchQueue.main.async {
                    // wait for loading of detail data
                    // before doing seque
                    self.performSegue(withIdentifier: "mapToDetailSegue", sender: self)
                }
            }
        }
        return true
    }
}
