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
    @IBOutlet weak var tableView: UITableView!
    
    var location: Location?
    var reviews: [String] = []
    
    enum ReviewTableCell: String {
        case reviewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let location = location {
            locationName.text = location.locationName
            locationDescription.text = location.locationDescription
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LocationsClient.getReviews(withKey: location?.keyIdentifier ?? "") { (reviews) in
            if reviews.isEmpty {
                self.hideTableView(true)
                return
            } else {
                self.hideTableView(false)
            }
            self.tableView.beginUpdates()
            for (index, _) in self.reviews.enumerated().reversed() {
                self.tableView.deleteRows(at: [IndexPath.init(row: index, section: 0)], with: .fade)
                self.reviews.remove(at: index)
            }
            for (index, location) in reviews.enumerated() {
                self.reviews.append(location)
                self.tableView.insertRows(at: [IndexPath.init(row: index, section: 0)], with: .fade)
            }
            self.tableView.endUpdates()
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? LocationReviewsViewController {
            viewController.location = location
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

// MARK: - TableView Delegate and Data Source

extension LocationDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableCell.reviewCell.rawValue, for: indexPath) as? ReviewTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ReviewTableViewCell {
            cell.confugureCell(with: reviews[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

// MARK: - Layout configs

extension LocationDetailsViewController {
    
    func hideTableView(_ hidden: Bool) {
        tableView.isHidden = hidden
    }
    
}
