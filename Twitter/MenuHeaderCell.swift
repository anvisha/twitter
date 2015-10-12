//
//  MenuHeaderCell.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/11/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class MenuHeaderCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameLabel.text = User.currentUser?.name
        screennameLabel.text = User.currentUser?.screenname
        profileImageView.setImageWithURL(NSURL(string: (User.currentUser?.profileImageUrl)!))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
