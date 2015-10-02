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
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                //perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                //handle login error
                print("error logging in")
            }
        }
        
        print("Button clicked")
            }


}

