//
//  NearMeVC.swift
//  AutoSquadron
//
//  Created by Vivek Rai on 01/10/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearMeVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mapSegmentedControl: UISegmentedControl!
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 5000

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        
        self.mapSegmentedControl.addTarget(self, action: #selector(changeMapType), for: .valueChanged)

        
    }
    
    
    @objc func changeMapType(segmentedControl: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.mapView.mapType = .standard
        case 1:
            self.mapView.mapType = .satellite
        case 2:
            self.mapView.mapType = .hybrid
        default:
            self.mapView.mapType = .standard
        }
    }
    
    
    

    @IBAction func centreLocationButton(_ sender: Any) {
        
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
        print("Centred!")

    }
    
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    @IBAction func locateServiceStation(_ sender: Any) {
        
        let alertVC = UIAlertController(title: "Enter Point of Interest", message: nil, preferredStyle: .alert)
        
        alertVC.addTextField { textField in
            
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            
            if let textField = alertVC.textFields?.first,
                let search = textField.text {
                
                self.findNearbyPOI(by :search)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    
     func findNearbyPOI(by searchTerm :String) {
        
        
        let annotations = self.mapView.annotations
        self.mapView.removeAnnotations(annotations)
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchTerm
        request.region = self.mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response, error == nil else {
                return
            }
            
            for mapItem in response.mapItems {
                self.addPlacemarkToMap(placemark :mapItem.placemark)
            }
            
        }
        
    }
    
     func addPlacemarkToMap(placemark :CLPlacemark) {
        
        let coordinate = placemark.location?.coordinate
        let annotation = MKPointAnnotation()
        annotation.title = placemark.name
        annotation.coordinate = coordinate!
        self.mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        
        mapView.setRegion(region, animated: true)
    }
    
    
}
