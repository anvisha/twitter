//
//  TweetCell.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/4/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate {
    optional func replyClicked(tweet: Tweet)
}

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var buttonProfileImage: UIButton!
    
    weak var delegate: TweetCellDelegate?

    var tweet: Tweet!{
        didSet {
            userNameLabel.text = tweet.user?.name
            userNameLabel.sizeToFit()
            userScreennameLabel.text = "@\(tweet.user?.screenname as String!)"
            userProfileImageView!.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!))
            userProfileImageView.setImageWithURLRequest(NSURLRequest(URL: NSURL(string: (tweet.user?.profileImageUrl)!)!), placeholderImage: nil, success: { (url: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in
                if self.buttonProfileImage != nil {
                    self.buttonProfileImage.setImage(image, forState: UIControlState.Normal)}

                }) { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
                    print("error")
            }
            bodyLabel.text = tweet.text
            timestampLabel.text = getTimestampLabel(tweet.createdAt!)
            if tweet.favorited == true {
                favoriteButton.imageView?.image = UIImage(named: "favorite_on.png")
            }
            if tweet.retweeted == true {
                retweetButton.imageView?.image = UIImage(named: "retweet_on.png")
            }
            if tweet.retweeter != nil {
                let retweetLabel = UILabel()
                self.addSubview(retweetLabel)
//                let labelConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V: |-8-[retweetLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["superview": self as! AnyObject, "retweetLabel": retweetLabel as! AnyObject])
//                self.addConstraints(labelConstraint)
//
                
            }
//            buttonProfileImage.setImage(userProfileImageView!.image, forState: UIControlState.Normal)

        }
    }
    
    func getTimestampLabel(createdAt: NSDate) -> (String) {
        let cleanFormat = NSDateFormatter()
        cleanFormat.dateFormat = "M/d/yy"
        let cleanDate = cleanFormat.stringFromDate(createdAt)
        return cleanDate
    }
    
    @IBAction func onFavorited(sender: AnyObject) {
        TwitterClient.sharedInstance.starTweet(tweet.id!) { () -> () in
            favoriteButton.imageView?.image = UIImage(named: "favorite_on.png")
        }
    }
    
    @IBAction func onRetweeted(sender: AnyObject) {
        TwitterClient.sharedInstance.retweetTweet(tweet.id!) { () -> () in
            retweetButton.imageView?.image = UIImage(named: "retweet_on.png")
        }
    }
    
    @IBAction func onReplyClicked(sender: AnyObject) {
        delegate?.replyClicked!(tweet)
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
