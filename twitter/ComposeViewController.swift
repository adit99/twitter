//
//  ComposeViewController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func didTweetSuceed(sender: ComposeViewController)
}

class ComposeViewController: UIViewController {

    var user : User?
    var delegate : ComposeViewControllerDelegate?
    var tweet: Tweet?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var tweetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let usr = self.user {
            self.tweet = nil
            userName.text = usr.name!
            screenName.text = "@\(usr.screenName!)"
            let url = NSURL(string: usr.profileImageURL!)
            let url_request = NSURLRequest(URL: url!)
            self.profileImage.setImageWithURL(url)
        } else if let twt = self.tweet {
            self.user = twt.user!
            userName.text = twt.user!.name!
            screenName.text = "@\(twt.user!.screenName!)"
            tweetLabel.hidden = false
            tweetLabel.text = twt.text!
            println(twt.text!)
            tweetText.text = "@\(twt.user!.screenName!)"
            let url = NSURL(string: twt.user!.profileImageURL!)
            let url_request = NSURLRequest(URL: url!)
            self.profileImage.setImageWithURL(url)
        }
        
        tweetText.layer.cornerRadius = 5
        tweetText.layer.borderColor = UIColor.blackColor().CGColor
        tweetText.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        println("attempting a tweet : \(tweetText.text)")
        self.user!.sendTweetWithCompletion(tweetText.text) {
            (error: NSError?) in
            if error == nil {
                println("tweet suceeded")
                self.delegate?.didTweetSuceed(self)
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                //handle login error
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        
    }

 

}
