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
    var refreshControl : UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register tweet cell
        let nib = UINib(nibName: "TweetViewCell", bundle: NSBundle.mainBundle())
        self.tabView.registerNib(nib, forCellReuseIdentifier: "TweetViewCell")
        
        //auto layout
        self.tabView.rowHeight = UITableViewAutomaticDimension
        
        //SVProgressHUD.show()

        //load home timeline
        loadHomeTimeline()
    
        //SVProgressHUD.dismiss()

        
        //pull to refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tabView.insertSubview(self.refreshControl!, atIndex: 0)
        
        //initialize tweets array
        self.tweets = [Tweet]()
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
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected row")
        
        self.performSegueWithIdentifier("gototweet", sender: self.tweets?[indexPath.row])
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var tweet = sender as Tweet
        let tweetDetailsVC = segue.destinationViewController as TweetDetailsViewController
        tweetDetailsVC.tweet = tweet
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
   
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func onRefresh() {
        loadHomeTimeline(sinceID: self.tweets![0].tweetID!)
    }
    
    func loadHomeTimeline(sinceID : NSString = "") {
        User.currentUser?.homeTimelineWithCompletion(sinceID : sinceID) {
            (tweets: [Tweet]?, error: NSError?) in
            if error == nil {
                if self.tweets?.count != 0 {
                    var arr = tweets! + self.tweets!
                    self.tweets = arr
                } else {
                    self.tweets = tweets
                }
                //self.tweets = (self.tweets?.count != 0) ? tweets : (self.tweets + tweets))
                println(tweets?.count)
                self.tabView.reloadData()
                self.refreshControl?.endRefreshing()
            } else {
                //handle getting hometimeline error
            }
        }
    }
}
