//
//  ReviewTableViewCell.swift
//  Drone Safely
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 14/11/17.
//  Copyright © 2017 Leonardo Vinicius Kaminski Ferreira. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewDescription: UILabel!
    
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

extension ReviewTableViewCell {
    func confugureCell(with review: String) {
        reviewDescription.text = review
    }
}

