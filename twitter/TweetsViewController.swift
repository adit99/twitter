//
//  TweetsViewController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/19/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets : [Tweet]?
    @IBOutlet weak var tabView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TweetViewCell", bundle: NSBundle.mainBundle())
        self.tabView.registerNib(nib, forCellReuseIdentifier: "TweetViewCell")
        
        self.tabView.rowHeight = UITableViewAutomaticDimension
        
        User.currentUser?.homeTimelineWithCompletion() {
        (tweets: [Tweet]?, error: NSError?) in
            if error == nil {
                self.tweets = tweets
                println(tweets?.count)
                self.tabView.reloadData()
            } else {
                //handle getting hometimeline error
            }
        }

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetViewCell") as TweetViewCell
        cell.loadCellContents(self.tweets![indexPath.row])
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweetsArray = self.tweets  {
            return tweetsArray.count
        } else {
            return 0
        }
    }
   
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
   
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    

}
