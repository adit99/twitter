//
//  TapGestureController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/22/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

class TapGestureController : UIViewController {
    
    func handleReply(gesture: UITapGestureRecognizer) {
        println("handle reply")
    }
    
    func handleFavorite(gesture: UITapGestureRecognizer, sender: UIViewController, tweet: Tweet) {
       
        println("handle favorite")
        var favoriteImageView = gesture.view! as UIImageView

        //send the favorite request
        tweet.user!.favoriteTweetWithCompletion(tweet.tweetID!) {
            (error: NSError?) in
            if error == nil {
                println("favorting tweet suceeded")
                favoriteImageView.image = ImageAssets.Instance.onFavoriteImage!.image
            } else {
                println("favoriting tweet failed")
            }
        }
    }
    
    func handleRetweet(gesture: UITapGestureRecognizer, sender: UIViewController, tweet: Tweet) {
        println("handle retweet")
        
        // Create the alert controller
        var alertController = UIAlertController(title: "Confirm Retweet?", message: "", preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            println("user confirmed rewteet")
            var retweetImageView = gesture.view! as UIImageView
            
            //send the rewteet
            tweet.user!.sendRetweetWithCompletion(tweet.tweetID!) {
                (error: NSError?) in
                if error == nil {
                    println("retweet suceeded")
                    retweetImageView.image = ImageAssets.Instance.onRetweetImage!.image
                } else {
                    //handle retweet error
                    println("retweet failed")
                }
            }
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("retweet canceled")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        sender.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
}