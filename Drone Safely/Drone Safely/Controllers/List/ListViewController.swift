//
//  ListViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit

class ListViewController: BaseDroneSafelyViewController {

    @IBOutlet weak var tableView: UITableView!
    var locations: [Location] = []
    
    enum ListTableCell: String {
        case listLocationsTableViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let location = sender as? Location {
            if let locationDetails = segue.destination as? LocationDetailsViewController {
                locationDetails.location = location
            }
        }
    }
    
    // MARK: - Overriding Actions
    
    override func refreshLocationsPressed(_ sender: Any) {
        refreshLocations()
    }

}

// MARK: - TableView Delegate and Data Source

extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.listLocationsTableViewCell.rawValue, for: indexPath) as? ListLocationTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ListLocationTableViewCell {
            cell.confugureCell(with: locations[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showLocationDetail", sender: locations[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

// MARK: - Refresh Students Locations

extension ListViewController {
    func refreshLocations() {
        refreshButton(enabled: false)
        LocationsClient.getLocations { (locations) in
            self.refreshButton(enabled: true)
            self.tableView.beginUpdates()
            for (index, _) in self.locations.enumerated().reversed() {
                self.tableView.deleteRows(at: [IndexPath.init(row: index, section: 0)], with: .fade)
                self.locations.remove(at: index)
            }
            for (index, location) in locations.enumerated() {
                self.locations.append(location)
                self.tableView.insertRows(at: [IndexPath.init(row: index, section: 0)], with: .fade)
            }
            self.tableView.endUpdates()
            self.tableView.reloadData()
        }
    }
}
