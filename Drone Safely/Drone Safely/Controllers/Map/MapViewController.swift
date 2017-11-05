//
//  MapViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseDroneSafelyViewController {
    
    enum PinIdentifier: String {
        case pin
    }

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: LocationManagerHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshStudentsLocations()
        locationManager = LocationManagerHelper.init(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    override func refreshStudentsLocationsPressed(_ sender: Any) {
        refreshStudentsLocations()
    }

}

// MARK: - Map adding locations

extension MapViewController {
    func addLocationsToMap() {
        
        var annotations = [MKPointAnnotation]()
        
//        for studentLocation in locations {
//            
//            let lat = CLLocationDegrees(studentLocation.latitude)
//            let long = CLLocationDegrees(studentLocation.longitude)
//            
//            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
//            
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = coordinate
//            annotation.title = "\(studentLocation.firstName) \(studentLocation.lastName)"
//            annotation.subtitle = studentLocation.mediaURL
//            
//            annotations.append(annotation)
//        }
        
        self.mapView.addAnnotations(annotations)
    }
}

extension MapViewController {
    func refreshStudentsLocations () {
        refreshButton(enabled: false)
        
    }
}

// MARK : - MKMapView Delegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: PinIdentifier.pin.rawValue)
        
        if annotation.coordinate.latitude == mapView.userLocation.coordinate.latitude && annotation.coordinate.longitude == mapView.userLocation.coordinate.longitude {
            return nil
        }
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: PinIdentifier.pin.rawValue)
            pinView!.canShowCallout = true
            pinView!.image = #imageLiteral(resourceName: "drone")
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let subtitle = view.annotation?.subtitle, let url = subtitle {
                self.presentWebPageInSafari(withURLString: url)
            }
        }
    }
    
}

// MARK: LocationManagerHelper Delegate

extension MapViewController: LocationManagerHelperDelegate {
    func didReceiveRegion(_ region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }
}
