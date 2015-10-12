//
//  Tweet.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/2/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: String?
    var favorited: Bool?
    var retweeted: Bool?
    var retweeter: User?
    
    init(var dictionary: NSDictionary) {
        if dictionary["retweeted_status"] != nil {
            retweeter = User(dictionary: (dictionary["user"] as? NSDictionary)!)
            dictionary = dictionary["retweeted_status"] as! NSDictionary
        }
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id_str"] as? String
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        favorited = dictionary["favorited"] as? Bool
        retweeted = dictionary["retweeted"] as? Bool
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
