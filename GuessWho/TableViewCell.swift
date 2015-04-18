//
//  TableViewCell.swift
//  Guesswho
//
//  Created by fhict on 17/04/15.
//  Copyright (c) 2015 fhict. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var lblmatch: UILabel!
    
    @IBOutlet weak var lbluser: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
