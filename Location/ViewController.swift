//
//  ViewController.swift
//  Location
//
//  Created by Zulyar Kurban on 6/20/18.
//  Copyright © 2018 Zulyar Kurban. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapKit: MKMapView!
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = 1.0
        locationManager.startUpdatingLocation()
        
        
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted ||
            CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                   locationManager.requestWhenInUseAuthorization()
            }
            
        } else {
            print("Please turn on location services or GPS")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let userlocation = CLLocationCoordinate2D(latitude:location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: userlocation, span: span)

        mapKit.setRegion(region, animated: true)
        
        self.mapKit.showsUserLocation = true
        
        let locationValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        print("locatins\(locationValue.latitude),\(locationValue.longitude)")
        
        
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("unable to  access your current location")
    }
}

