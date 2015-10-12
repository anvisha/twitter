//
//  ProfileStatsCell.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/11/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class ProfileStatsCell: UITableViewCell {

    var activeUser: User!{
        didSet{
            followersCount.text = String(activeUser.followersCount!)
            followingCount.text = String(activeUser.friendsCount!)
            statusesCount.text = String(activeUser.statusesCount!)
        }
    }
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var statusesCount: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
