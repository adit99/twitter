//
//  CodePathTwitterClient.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/17/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit


func valueForAPIKey(#keyname:String) -> String {
    let filePath = NSBundle.mainBundle().pathForResource("Environments", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value:String = plist?.objectForKey(keyname) as String
    return value
}

class CodePathTwitterClient: BDBOAuth1RequestOperationManager {
   
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var Instance : CodePathTwitterClient {
        struct Static {
            static let instance = CodePathTwitterClient(baseURL: NSURL(string: valueForAPIKey(keyname: "BaseURL")), consumerKey: valueForAPIKey(keyname: "ConsumerKey"), consumerSecret: valueForAPIKey(keyname: "ConsumerSecret"))
        }
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        self.loginCompletion = completion
    
        //fetch request token and redirect to auth page
        CodePathTwitterClient.Instance.requestSerializer.removeAccessToken()
        
        CodePathTwitterClient.Instance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {(requestToken:BDBOAuth1Credential!) -> Void in
            println("Got the request token")
            var authURLString = valueForAPIKey(keyname: "AuthURL")
            var authURL = NSURL(string: authURLString + requestToken.token)
            println(authURLString + requestToken.token)
            UIApplication.sharedApplication().openURL(authURL!)
            }) {(error: NSError!) -> Void in
                println("Failed to get the request token")
        }
    }
    
}
