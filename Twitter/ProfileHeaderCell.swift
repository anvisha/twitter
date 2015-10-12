//
//  ProfileHeaderCell.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/11/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {
    var activeUser: User!{
        didSet{
            profileImageView.setImageWithURL(NSURL(string: (activeUser?.profileImageUrl)!))
            nameLabel.text = activeUser?.name
            screenNameLabel.text = activeUser?.name
            backgroundImageView.setImageWithURL(NSURL(string: (activeUser?.backgroundImageUrl)!))
            backgroundImageView.contentMode = .ScaleAspectFit

        }
    }
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
