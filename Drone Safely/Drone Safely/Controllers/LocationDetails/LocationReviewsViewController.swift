//
//  LocationReviewsViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 14/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit

class LocationReviewsViewController: UIViewController {

    @IBOutlet weak var textView: DesignableTextView!
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func sendReviewPressed(_ sender: Any) {
        LocationsClient.postNewReview(withKey: location?.keyIdentifier ?? "", text: textView.text)
        navigationController?.popViewController(animated: true)
    }
    

}
