//
//  Tweet.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/17/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit



class Tweet: NSObject {
    var user : User?
    var text : NSString?
    var createdAtString: NSString?
    var createdAt : NSDate?
    var tweetID : NSString?
    var favoriteCount : Int?
    var retweetCount : Int?
    
    init(dictionary: NSDictionary) {
        self.user = User(dictionary: dictionary["user"] as NSDictionary)
        self.text = dictionary["text"] as? NSString
        self.createdAtString = dictionary["created_at"] as? NSString
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm::ss Z y"
        self.createdAt = formatter.dateFromString(self.createdAtString!)
        self.tweetID = dictionary["id_str"] as? NSString
        self.favoriteCount = dictionary["favorite_count"] as? Int
        self.retweetCount = dictionary["retweet_count"] as? Int

        //println(dictionary)
    }
    

    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }
}
