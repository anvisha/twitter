//
//  TweetCell.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/4/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    var tweet: Tweet!{
        didSet {
            userNameLabel.text = tweet.user?.name
            userScreennameLabel.text = "@\(tweet.user?.screenname as String!)"
            userProfileImageView.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!))
            bodyLabel.text = tweet.text
            timestampLabel.text = getTimestampLabel(tweet.createdAt!)
        }
    }
    
    func getTimestampLabel(createdAt: NSDate) -> (String) {
        let cleanFormat = NSDateFormatter()
        cleanFormat.dateFormat = "M/d/yy"
        let cleanDate = cleanFormat.stringFromDate(createdAt)
        return cleanDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
