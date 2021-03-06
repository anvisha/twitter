//
//  User.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/2/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"



class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary?
    var backgroundImageUrl: String?
    var followersCount: Int?
    var friendsCount: Int?
    var statusesCount: Int?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        backgroundImageUrl = dictionary["profile_background_image_url"] as? String
        tagline = dictionary["tagline"] as? String
        followersCount = dictionary["followers_count"] as? Int
        friendsCount = dictionary["friends_count"] as? Int
        statusesCount = dictionary["statuses_count"] as? Int
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey)
                if let d = data {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(d as! NSData, options: NSJSONReadingOptions.MutableContainers)
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user

            if let current = _currentUser {
                let data = try! NSJSONSerialization.dataWithJSONObject(current.dictionary!, options: NSJSONWritingOptions.PrettyPrinted)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
