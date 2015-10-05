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
    var replyTweet: String?
    var replyScreenName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User.currentUser!
        profileImageView.setImageWithURL(NSURL(string: user.profileImageUrl!))
        userNameLabel.text = user.name
        userScreennameLabel.text = "@\(user.screenname!)"
        print("Is there a reply: \(replyTweet)")
        // Do any additional setup after loading the view.
        tweetTextArea.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        if replyTweet != nil {
            tweetTextArea.text = "@\(replyScreenName!)"
        }
    }

    @IBAction func onTweetClicked(sender: AnyObject) {
        TwitterClient.sharedInstance.postTweet(tweetTextArea.text, replyTweetId: replyTweet) { () -> () in
             NSNotificationCenter.defaultCenter().postNotificationName(tweetPostedNotification, object: nil)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        replyTweet = nil
        replyScreenName = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelClicked(sender: AnyObject) {
        print("cancel clicked")
        self.navigationController?.popViewControllerAnimated(true)
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
