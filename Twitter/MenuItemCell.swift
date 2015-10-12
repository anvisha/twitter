
//
//  MenuItemCell.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/11/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    var rowIndex: Int!{
        didSet {
            var rowLabelText = ""
            switch rowIndex!{
            case 0:
                rowLabelText = "Home Timeline"
            case 1:
                rowLabelText = "Profile"
            case 2:
                rowLabelText = "Mentions"
            default:
                rowLabelText = "Oops"
            }
            menuItemButton.setTitle(rowLabelText, forState: UIControlState.Normal)

        }
    }
    @IBOutlet weak var menuItemButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        menuItemButton.sizeToFit()
        
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
