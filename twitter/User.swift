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
    var backgroundImageURL: NSString?
    var profileBannerURL: NSString?
    var dictionary : NSDictionary?
    var followersCount: Int?
    var tweets: Int?
    var followingCount: Int?
    var location: NSString?
    var id : NSString?

    init(dictionary: NSDictionary) {
        self.name = dictionary["name"] as? NSString
        self.screenName = dictionary["screen_name"] as? NSString
        self.profileImageURL = dictionary["profile_image_url"] as? NSString
        self.backgroundImageURL = dictionary["profile_background_image_url"] as? NSString
        self.profileBannerURL =  dictionary["profile_banner_url"] as? NSString
        self.followersCount = dictionary["followers_count"] as? Int
        self.tweets = dictionary["statuses_count"] as? Int
        self.followingCount = dictionary["friends_count"] as? Int
        self.tagLine = dictionary["description"] as? NSString
        self.location = dictionary["location"] as? NSString
        self.id = dictionary["id_str"] as? NSString
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
    
    func homeTimelineWithCompletion(sinceID: String = "", completion: (tweets: [Tweet], error: NSError?) -> ()) {
        
        var parameters = NSMutableDictionary()
        parameters["since_id"] = sinceID
               
        CodePathTwitterClient.Instance.GET("1.1/statuses/home_timeline.json", parameters: (parameters["since_id"] as NSString != "") ? parameters : nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("got home timeline")
                var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
                completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting home timeline")
                completion(tweets: [Tweet](), error: error)
        })

    }
    
    func userTimelineWithCompletion(sinceID: String = "", completion: (tweets: [Tweet], error: NSError?) -> ()) {
        
        var parameters = NSMutableDictionary()
        parameters["screen_name"] = screenName
        //parameters["since_id"] = sinceID
        
        CodePathTwitterClient.Instance.GET("1.1/statuses/user_timeline.json", parameters: parameters, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("got user timeline")
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting user timeline")
                completion(tweets: [Tweet](), error: error)
        })
        
    }
    
    
    func mentionsTimelineWithCompletion(completion: (tweets: [Tweet], error: NSError?) -> ()) {
        
        CodePathTwitterClient.Instance.GET("1.1/statuses/mentions_timeline.json", parameters: nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("got user mentions timeline")
            var tweets = Tweet.tweetsWithArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting user mentions timeline")
                completion(tweets: [Tweet](), error: error)
        })
        
    }
    
    func sendTweetWithCompletion(tweetText: String, completion: (error: NSError?) -> ()) {
     
        var parameters = NSMutableDictionary()
        parameters["status"] = tweetText
        
        CodePathTwitterClient.Instance.POST("1.1/statuses/update.json", parameters: parameters, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("successfully sent tweet")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error sending tweet")
                completion(error: error)
        })
    }
    
    func replyToTweetWithCompletion(tweetText: String, replyTweetID: NSString, completion: (error: NSError?) -> ()) {
        
        var parameters = NSMutableDictionary()
        parameters["status"] = tweetText
        parameters["in_reply_to_status_id"] = replyTweetID
        
        CodePathTwitterClient.Instance.POST("1.1/statuses/update.json", parameters: parameters, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("successfully sent tweet")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error sending tweet")
                completion(error: error)
        })
    }
    
    func sendRetweetWithCompletion(tweetID: String, completion: (error: NSError?) -> ()) {
        
        var url = "https://api.twitter.com/1.1/statuses/retweet/\(tweetID).json"
        println(url)
        
        CodePathTwitterClient.Instance.POST(url, parameters: nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("successfully sent retweet")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error sending retweet")
                completion(error: error)
        })
    }
    
    func sendRetweetDeleteWithCompletion(tweetID: String, completion: (error: NSError?) -> ()) {
        
        var url = "https://api.twitter.com/1.1/statuses/destroy/\(tweetID)/.json"
        println(url)
        
        CodePathTwitterClient.Instance.POST(url, parameters: nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("successfully deleted retweet")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error sending retweet delete")
                completion(error: error)
        })
    }
    
    func favoriteTweetWithCompletion(tweetID: String, completion: (error: NSError?) -> ()) {
        
        var parameters = NSMutableDictionary()
        parameters["id"] = tweetID
        
        CodePathTwitterClient.Instance.POST("1.1/favorites/create.json", parameters: parameters, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("successfully favorited tweet")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error favoriting retweet")
                completion(error: error)
        })
    }
    
    func unFavoriteTweetWithCompletion(tweetID: String, completion: (error: NSError?) -> ()) {
        
        var parameters = NSMutableDictionary()
        parameters["id"] = tweetID
        
        CodePathTwitterClient.Instance.POST("1.1/favorites/destroy.json", parameters: parameters, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("successfully favorited tweet")
            completion(error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error favoriting retweet")
                completion(error: error)
        })
    }
    
    func logout() {
        User.currentUser = nil
        CodePathTwitterClient.Instance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(valueForAPIKey(keyname: "userDidLogout"), object: nil)
    }
}
