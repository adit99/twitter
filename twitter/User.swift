//
//  User.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/17/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

var _currentUser: User?
let _currentUserKey = "currentUser"

class User: NSObject {

    var name : NSString?
    var screenName : NSString?
    var profileImageURL: NSString?
    var tagLine : NSString?
    var dictionary : NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.name = dictionary["name"] as? NSString
        self.screenName = dictionary["screen_name"] as? NSString
        self.profileImageURL = dictionary["profile_image_url"] as? NSString
        self.tagLine = dictionary["description"] as? NSString
        self.dictionary = dictionary
    }
    
    class var currentUser : User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(_currentUserKey) as? NSData
                if (data != nil) {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: _currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: _currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func homeTimelineWithCompletion(completion: (tweets: [Tweet], error: NSError?) -> ()) {

        CodePathTwitterClient.Instance.GET("1.1/statuses/home_timeline.json", parameters: nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting home timeline")
                completion(tweets: [Tweet](), error: error)
        })

    }
    
    func logout() {
        User.currentUser = nil
        CodePathTwitterClient.Instance.requestSerializer.removeAccessToken()
    
        NSNotificationCenter.defaultCenter().postNotificationName(valueForAPIKey(keyname: "userDidLogout"), object: nil)
    }
}
