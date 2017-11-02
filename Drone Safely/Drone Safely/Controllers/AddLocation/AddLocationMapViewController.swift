//
//  AddLocationMapViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var coordinate: CLLocationCoordinate2D?
    var mediaURL: String?
    var mapString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMapLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    
    
    @IBAction func postLocationPressed(_ sender: Any) {
        
        if let mapString = mapString, let mediaURL = mediaURL, let coordinate = coordinate {
            self.view.startLoadingAnimation()
            
        }
    }
    
}

// MARK: - Map Settings

extension AddLocationMapViewController {
    func setMapLocation() {
        if let coordinate = coordinate {
            let latitude = coordinate.latitude
            let longitude = coordinate.longitude
            let latDelta: CLLocationDegrees = 0.005
            let lonDelta: CLLocationDegrees = 0.005
            let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            self.mapView.setRegion(region, animated: true)
            let point = MKPointAnnotation()
            point.coordinate = coordinate
            let userAnnotationView:MKPinAnnotationView = MKPinAnnotationView(annotation: point, reuseIdentifier: nil)
            self.mapView.addAnnotation(userAnnotationView.annotation!)
            self.mapView.showsUserLocation = true
        }
    }
}
