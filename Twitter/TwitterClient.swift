//
//  TwitterClient.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/1/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

let twitterConsumerKey = "6upXGwq9UuD65ZY1M5T5yu0ps"
let twitterConsumerSecret = "9Sgd3hQpavkxIHlzEEMnDoVursp4id9H7XQiL7Wvh1pdkZb6RA"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1RequestOperationManager {
    
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
}
