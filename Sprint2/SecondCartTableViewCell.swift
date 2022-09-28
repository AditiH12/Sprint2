//
//  SecondCartTableViewCell.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/28/22.
//

import UIKit

class SecondCartTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var nameOfItemLabel: UILabel!
    
    
    @IBOutlet weak var descriptionOfItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
