//
//  AddToCartTableViewCell.swift
//  Sprint2
//
//  Created by Capgemini-DA073 on 9/26/22.
//

import UIKit
import Alamofire

class AddToCartTableViewCell: UITableViewCell {       //Class to display and add items to cart begins.


    @IBOutlet weak var itemNameLabel: UILabel!              //Outlet for Name of the Item Label.
    @IBOutlet weak var itemDescriptionLabel: UILabel!       //Outlet for Item Description Label.
    
    
    @IBOutlet weak var addingToCartBtnClicked: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}                                                     //Class to display and add items to cart ends.
