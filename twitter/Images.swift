//
//  Images.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

func valueForAPIKeyFromDictionary(#dictionaryName:String, #keyname:String) -> NSString {
    let filePath = NSBundle.mainBundle().pathForResource("Environments", ofType:"plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let dict:NSDictionary = plist?.objectForKey(dictionaryName) as NSDictionary
    let value:NSString = dict[keyname] as NSString
    return value
}

class ImageAssets {
    
    var defaultFavoriteImage : UIImageView?
    var hoverFavoriteImage : UIImageView?
    var onFavoriteImage : UIImageView?
    
    var defaultReplyImage : UIImageView?
    var hoverReplyImage : UIImageView?
    
    var defaultRetweetImage : UIImageView?
    var hoverRetweetImage : UIImageView?
    var onRetweetImage :  UIImageView?
 
    init() {
        
        defaultFavoriteImage = getImage(valueForAPIKeyFromDictionary(dictionaryName: "ImageAssets", keyname: "defaultFavorite"))
        hoverFavoriteImage = getImage(valueForAPIKeyFromDictionary(dictionaryName: "ImageAssets", keyname: "hoverFavorite"))
        onFavoriteImage = getImage(valueForAPIKeyFromDictionary(dictionaryName: "ImageAssets", keyname: "onFavorite"))
     
        defaultReplyImage = getImage(valueForAPIKeyFromDictionary(dictionaryName: "ImageAssets", keyname: "defaultReply"))
        hoverReplyImage = getImage(valueForAPIKeyFromDictionary(dictionaryName: "ImageAssets", keyname: "hoverReply"))
       
        defaultRetweetImage = getImage(valueForAPIKeyFromDictionary(dictionaryName: "ImageAssets", keyname: "defaultRetweet"))
        hoverRetweetImage = getImage(valueForAPIKeyFromDictionary(dictionaryName: "ImageAssets", keyname: "hoverRetweet"))
        onRetweetImage = getImage(valueForAPIKeyFromDictionary(dictionaryName: "ImageAssets", keyname: "onRetweet"))
    }
    
    func getImage(imageURL: NSString?) -> UIImageView {
        let url = NSURL(string: imageURL!)
        let url_request = NSURLRequest(URL: url!)
        let placeholder = UIImage(named: "no_photo")
        var imageView  = UIImageView()
        imageView.setImageWithURL(url)
        return imageView
    }
    
    
    class var Instance : ImageAssets {
        struct Static {
            static let instance = ImageAssets()
        }
        return Static.instance
    }
    
}