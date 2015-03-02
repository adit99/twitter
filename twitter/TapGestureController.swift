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
        
        println("Current State : \(favoriteImageView.highlighted)")
        
        switch favoriteImageView.highlighted {
            case false:
                setFavorite(gesture, tweet: tweet)
                break
    
            case true:
                unSetFavorite(gesture, tweet: tweet)
                break
            
            default :
                break
        }
    }
    
    func setFavorite(gesture: UITapGestureRecognizer, tweet: Tweet) {
       
        var favoriteImageView = gesture.view! as UIImageView
        
        //send the favorite request
        tweet.user!.favoriteTweetWithCompletion(tweet.tweetID!) {
            (error: NSError?) in
            if error == nil {
                println("favorting tweet suceeded")
                favoriteImageView.image = ImageAssets.Instance.onFavoriteImage!.image
                favoriteImageView.highlighted = true
                tweet.favoriteCount! += 1
                tweet.favorited = 1
            } else {
                println("favoriting tweet failed")
            }
        }
    }
    
    func unSetFavorite(gesture: UITapGestureRecognizer, tweet: Tweet) {
        
        var favoriteImageView = gesture.view! as UIImageView
        
        //send the un favorite request
        tweet.user!.unFavoriteTweetWithCompletion(tweet.tweetID!) {
            (error: NSError?) in
            if error == nil {
                println("unfavorting tweet suceeded")
                favoriteImageView.image = ImageAssets.Instance.defaultFavoriteImage!.image
                favoriteImageView.highlighted = false
                tweet.favoriteCount! -= 1
                tweet.favorited = 0
            } else {
                println("unfavoriting tweet failed")
            }
        }
    }
    
    func handleRetweet(gesture: UITapGestureRecognizer, sender: UIViewController, tweet: Tweet) {
        println("handle retweet")
        
        var retweetImageView = gesture.view! as UIImageView
        
        println("Current State : \(retweetImageView.highlighted)")
        
        switch retweetImageView.highlighted {
        case false:
            sendRetweet(gesture, sender: sender, tweet: tweet)
            break
            
        case true:
            deleteRetweet(gesture, sender: sender, tweet: tweet)
            break
            
        default :
            break
        }
    }
    
    func sendRetweet(gesture: UITapGestureRecognizer, sender: UIViewController, tweet: Tweet) {

        var retweetImageView = gesture.view! as UIImageView

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
                    retweetImageView.highlighted = true
                    tweet.retweeted = 1
                    tweet.retweetCount! += 1
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
    
    func deleteRetweet(gesture: UITapGestureRecognizer, sender: UIViewController, tweet: Tweet) {
        
        //Not implemented :(
        var retweetImageView = gesture.view! as UIImageView
        retweetImageView.image = ImageAssets.Instance.defaultRetweetImage!.image
        retweetImageView.highlighted = false
        tweet.retweeted = 0
        tweet.retweetCount! -= 1
        
        // Create the alert controller
       /* var alertController = UIAlertController(title: "Confirm Retweet Deletion?", message: "", preferredStyle: .Alert)
        
        // Create the actions
        var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            println("user confirmed rewteet delete")
            var retweetImageView = gesture.view! as UIImageView
            
            //send the rewteet
            tweet.user!.sendRetweetDeleteWithCompletion(tweet.tweetID!) {
                (error: NSError?) in
                if error == nil {
                    println("retweet delete suceeded")
                    retweetImageView.image = ImageAssets.Instance.defaultRetweetImage!.image
                    retweetImageView.accessibilityIdentifier = "default"
                } else {
                    //handle retweet error
                    println("retweet delete failed")
                }
            }
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            println("retweet delete canceled")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        sender.presentViewController(alertController, animated: true, completion: nil)*/
    }
    
    
}