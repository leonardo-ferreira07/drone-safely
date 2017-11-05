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
    var canAddPin: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshLocations()
        locationManager = LocationManagerHelper.init(self)
        addGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let coordinate = sender as? CLLocationCoordinate2D {
            if let viewController = segue.destination as? UINavigationController {
                if let addMapViewController = viewController.viewControllers.first as? ConfirmLocationMapViewController {
                    addMapViewController.coordinate = coordinate
                }
            }
        }
    }
    
    // MARK: - Actions
    
    override func refreshStudentsLocationsPressed(_ sender: Any) {
        refreshLocations()
    }

}

// MARK: - Map adding locations

extension MapViewController {
    func addLocationsToMap(_ locations: [Location]) {
        
        var annotations = [MKPointAnnotation]()
        if !locations.isEmpty {
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
        
        for location in locations {
            
            let lat = CLLocationDegrees(location.latitude)
            let long = CLLocationDegrees(location.longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = location.locationName
            annotation.subtitle = location.locationDescription
            
            annotations.append(annotation)
        }
        
        self.mapView.addAnnotations(annotations)
    }
}

extension MapViewController {
    func refreshLocations () {
        refreshButton(enabled: false)
        
        LocationsClient.getLocations { (locations) in
            self.refreshButton(enabled: true)
            self.addLocationsToMap(locations)
        }
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

// MARK: - UIGesture Recognizer

extension MapViewController {
    
    func addGesture() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(triggerLongpressOn(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func triggerLongpressOn(_ gestureRecognizer: UIGestureRecognizer) {
        
        if canAddPin {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinates
            annotation.title = "\(newCoordinates.latitude) \(newCoordinates.longitude)"
            performSegue(withIdentifier: "goToLocationStoryboard", sender: newCoordinates)
//            mapView.addAnnotation(annotation)
        }
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            canAddPin = false
        } else if gestureRecognizer.state == UIGestureRecognizerState.ended {
            canAddPin = true
        }
        
    }
    
}
