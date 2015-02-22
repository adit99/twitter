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
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = user!.name
        screenName.text = "@\(user!.screenName)"
        let url = NSURL(string: user!.profileImageURL!)
        let url_request = NSURLRequest(URL: url!)
        self.profileImage.setImageWithURL(url)
        
       
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
