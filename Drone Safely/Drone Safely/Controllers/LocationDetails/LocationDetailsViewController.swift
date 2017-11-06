//
//  LocationDetailsViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 06/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailsViewController: UIViewController {

    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationDescription: UITextView!
    
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let location = location {
            locationName.text = location.locationName
            locationDescription.text = location.locationDescription
        }
    }
    
    // MARK: - Actions
    
    @IBAction func navigateButtonPressed(_ sender: Any) {
        openMapForPlace()
    }
    
    
}

// MARK: - Apple Maps navigation

extension LocationDetailsViewController {
    func openMapForPlace() {
        guard let latitude = location?.latitude, let longitude = location?.longitude else {
            showAlert("Maps error", message: "Was not possible to trace a location to required place.")
            return
        }
        
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location?.locationName
        mapItem.openInMaps(launchOptions: options)
    }
}
