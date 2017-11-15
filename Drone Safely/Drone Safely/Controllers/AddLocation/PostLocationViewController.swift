//
//  AddLocationViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit
import CoreLocation

class PostLocationViewController: BaseDroneSafelyViewController {

    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var stackView: UIStackView!
    
    var coordinate: CLLocationCoordinate2D?
    
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resignTextFields()
    }
    
    // MARK: - Actions
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationPressed(_ sender: Any) {
        getGeocoder()
    }
    
    override func keyboardWillShow(_ notification: Notification) {
        self.stackView.spacing = 2
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        self.stackView.spacing = 10
    }

}

// MARK: - Geocoder actions

extension PostLocationViewController {
    func getGeocoder() {
        resignTextFields()
        
        guard let locationName = locationNameTextField.text, locationName.count > 0 else {
            showAlert("Location Error", message: "You must insert a location name before continue.")
            return
        }
        
        view.startLoadingAnimation()
        let location = Location(locationName: locationName,
                                locationDescription: descriptionTextView.text,
                                latitude: coordinate?.latitude ?? 0,
                                longitude: coordinate?.longitude ?? 0)
        LocationsClient.postNewLocation(location)
        view.stopLoadingAnimation()
        dismiss(animated: true, completion: nil)
        
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if error != nil {
            showAlert("Location Error", message: "Opsss. Unable to Forward Geocode Address")
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                coordinate = location.coordinate
                performSegue(withIdentifier: "showPostLocation", sender: nil)
            } else {
                showAlert("Location Error", message: "No Matching Location Found")
            }
        }
    }
}

// MARK: - Resign TextFields

extension PostLocationViewController {
    func resignTextFields() {
        locationNameTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }
}
