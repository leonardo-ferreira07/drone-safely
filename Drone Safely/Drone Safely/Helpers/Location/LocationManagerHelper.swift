//
//  LocationManagerHelper.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 05/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import MapKit

protocol LocationManagerHelperDelegate: NSObjectProtocol {
    func didReceiveRegion(_ region: MKCoordinateRegion)
}

class LocationManagerHelper: NSObject {
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    weak var delegate: LocationManagerHelperDelegate?
    
    convenience init(_ delegate: LocationManagerHelperDelegate) {
        self.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        self.delegate = delegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        startCheckingForLocation()
    }
    
    func startCheckingForLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
}

// MARK: - CLLocationManagerDelegate

extension LocationManagerHelper: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        
        if currentLocation == nil {
            if let userLocation = locations.last {
                let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
                delegate?.didReceiveRegion(viewRegion)
            }
        }
    }
}
