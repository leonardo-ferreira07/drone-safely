//
//  LocationDetailsViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 06/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
