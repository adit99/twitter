//
//  User.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/17/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class User: NSObject {

    var name : NSString?
    var screenName : NSString?
    var profileImageURL: NSString?
    var tagLine : NSString?
    
    init(dictionary: NSDictionary) {
        self.name = dictionary["name"] as? NSString
        self.screenName = dictionary["screen_name"] as? NSString
        self.profileImageURL = dictionary["profile_image_url"] as? NSString
        self.tagLine = dictionary["description"] as? NSString
    }
}
