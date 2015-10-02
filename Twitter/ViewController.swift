//
//  ViewController.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/1/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLogin(sender: AnyObject) {
        print("Button clicked")
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        print(TwitterClient.sharedInstance.baseURL)
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {
            (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            } ) {(error: NSError!) -> Void in
        print(error)}
    }


}

