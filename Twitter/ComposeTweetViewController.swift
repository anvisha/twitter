//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/4/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

let tweetPostedNotification = "tweetPostedNotification"

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreennameLabel: UILabel!
    @IBOutlet weak var tweetTextArea: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User.currentUser!
        profileImageView.setImageWithURL(NSURL(string: user.profileImageUrl!))
        userNameLabel.text = user.name
        userScreennameLabel.text = "@\(user.screenname!)"
        // Do any additional setup after loading the view.
        tweetTextArea.becomeFirstResponder()
    }

    @IBAction func onTweetClicked(sender: AnyObject) {
        TwitterClient.sharedInstance.postTweet(tweetTextArea.text) { () -> () in
            NSNotificationCenter.defaultCenter().postNotificationName(tweetPostedNotification, object: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
