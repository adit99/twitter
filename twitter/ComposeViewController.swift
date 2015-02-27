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

class ComposeViewController: UIViewController, UITextViewDelegate {

    var user : User?
    var delegate : ComposeViewControllerDelegate?
    var tweet: Tweet?
    //var sideBar:SideBar?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tweetCharCount: UILabel!
    
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
        
        tweetCharCount.hidden = true
        tweetText.delegate = self
        
        //viewDidLoadRedux()
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

    func textViewDidChange(textView: UITextView) {
       
        if (countElements(textView.text) == 141) {
            tweetText.text = tweetText.text.substringToIndex(advance(tweetText.text.startIndex,140))
        } else {
            let count = 140 - countElements(textView.text)
            tweetCharCount.hidden = false
            tweetCharCount.text = String(count)
        }
    }

    /*func viewDidLoadRedux() {
        println("view did load redux")
        sideBar = SideBar(sourceView: self.view,  menuItems: ["First", "Second", "Third"])
        sideBar!.delegate = self
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        println("side bar did select")
    }*/
    
}
