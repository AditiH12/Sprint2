//
//  InCartTableViewCell.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/27/22.
//

import UIKit

class InCartTableViewCell: UITableViewCell {

    
    //@IBOutlet weak var NameOfItemInCart: UILabel!
    
    //@IBOutlet weak var DescriptionOfItemInCart: UILabel!
    
    @IBOutlet weak var ItemNameInCart: UILabel!
    
    @IBOutlet weak var ItemDescriptionInCart: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
