//
//  ListStudentTableViewCell.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 02/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit

class ListStudentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentMediaLink: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - Configure cell

extension ListStudentTableViewCell {
//    func confugureCell(with studentLocation: StudentLocation) {
//        studentName.text = studentLocation.firstName + " " + studentLocation.lastName
//        studentMediaLink.text = studentLocation.mediaURL
//    }
}
