//
//  ListViewController.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit

class ListViewController: BaseOnTheMapViewController {

    @IBOutlet weak var tableView: UITableView!
    
    enum ListTableCell: String {
        case listStudentTableViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Overriding Actions
    
    override func refreshStudentsLocationsPressed(_ sender: Any) {
        refreshLocations()
    }

}

// MARK: - TableView Delegate and Data Source

//extension ListViewController: UITableViewDelegate, UITableViewDataSource {

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return MemoryStorage.shared.studentsLocations.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: ListTableCell.listStudentTableViewCell.rawValue, for: indexPath) as? ListStudentTableViewCell {
//            return cell
//        }
//        return UITableViewCell()
//    }
//    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let cell = cell as? ListStudentTableViewCell {
//            cell.confugureCell(with: MemoryStorage.shared.studentsLocations[indexPath.row])
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        presentWebPageInSafari(withURLString: MemoryStorage.shared.studentsLocations[indexPath.row].mediaURL)
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
    
//}

// MARK: - Refresh Students Locations

extension ListViewController {
    func refreshLocations() {
        refreshButton(enabled: false)
        
    }
}
