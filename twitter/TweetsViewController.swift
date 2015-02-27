//
//  TweetsViewController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/19/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate, TweetDetailsViewControllerDelegate, SideBarDelegate {

    var tweets : [Tweet]?
    //@IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tabView: UITableView!
    var refreshControl : UIRefreshControl?
    var tapCtrl : TapGestureController?
    let menu:Array<String> = ["Home", "Profile", "Mentions"]
    
    //redux
   var sideBar:SideBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register tweet cell
        let nib = UINib(nibName: "TweetViewCell", bundle: NSBundle.mainBundle())
        self.tabView.registerNib(nib, forCellReuseIdentifier: "TweetViewCell")
        
        //auto layout
        self.tabView.rowHeight = UITableViewAutomaticDimension
        

        //load home timeline
        loadHomeTimeline()
    
        //SVProgressHUD.dismiss()

        
        //pull to refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tabView.insertSubview(self.refreshControl!, atIndex: 0)
        
        //initialize tweets array
        self.tweets = [Tweet]()
        
        //Tap gestures
        tapCtrl = TapGestureController()
        
        //redux
        viewDidLoadRedux()
    }

    override func viewDidAppear(animated: Bool) {
        println("view did appear")
        super.viewDidAppear(animated)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetViewCell") as TweetViewCell
        cell.loadCellContents(self.tweets![indexPath.row])
        
        ImageAssets.Instance.addTapGestureForImageView(&(cell.replyImage!), target: self, selector: "replyTapped:")
        cell.replyImage!.tag = indexPath.row
        
        ImageAssets.Instance.addTapGestureForImageView(&(cell.favoriteLabel!), target: self, selector: "favoriteTapped:")
        cell.favoriteLabel!.tag = indexPath.row
        
        ImageAssets.Instance.addTapGestureForImageView(&(cell.retweetImage!), target: self, selector: "retweetTapped:")
        cell.retweetImage!.tag = indexPath.row
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let tweetsArray = self.tweets  {
            println(tweetsArray.count)
            return tweetsArray.count
        } else {
            return 0
        }
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected row")
        self.tabView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("gototweet", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("prepare for segue : \(segue.identifier!)")
        if (segue.identifier! == "gototweet") {
            var indexPath = sender as? NSIndexPath
            var tweet = self.tweets![indexPath!.row]
            let tweetDetailsVC = segue.destinationViewController as TweetDetailsViewController
            tweetDetailsVC.tweet = tweet
            tweetDetailsVC.delegate = self
            tweetDetailsVC.indexPath = indexPath
        }
        else if (segue.identifier! == "gotocompose") {
            var user = sender as User
            let composeVC = segue.destinationViewController as ComposeViewController
            composeVC.user = user
            composeVC.tweet = nil
            composeVC.delegate = self
        }
        else if (segue.identifier! == "gotoreply") {
            var tweet = sender as Tweet
            let composeVC = segue.destinationViewController as ComposeViewController
            composeVC.user = nil
            composeVC.tweet = tweet
            composeVC.delegate = self
        }
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
    
    @IBAction func onComponse(sender: AnyObject) {
        self.performSegueWithIdentifier("gotocompose", sender: User.currentUser)
    }
    
    func didTweetSuceed(sender: ComposeViewController) {
        println("did tweet succeed")
        loadHomeTimeline(sinceID: self.tweets![0].tweetID!)
    }
    
    func tweetDidChange(sender: TweetDetailsViewController, tweet: Tweet) {
        println("tweet did change")
        self.tweets![sender.indexPath!.row] = tweet
        loadHomeTimeline(sinceID: self.tweets![0].tweetID!)
    }
    
    func replyTapped(gesture: UITapGestureRecognizer) {
        println("reply tapped")
        var replyView = gesture.view as UIImageView
        self.performSegueWithIdentifier("gotoreply", sender: self.tweets![replyView.tag])
    }
    
    func retweetTapped(gesture: UITapGestureRecognizer) {
        println("retweet tapped")
        var retweetView = gesture.view as UIImageView
        tapCtrl!.handleRetweet(gesture, sender: self, tweet: self.tweets![retweetView.tag])
    }
    
    func favoriteTapped(gesture: UITapGestureRecognizer) {
        println("favorite tapped")
        tapCtrl!.handleFavorite(gesture, sender: self, tweet: self.tweets![(gesture.view as UIImageView).tag])
    }
    
    func loadHomeTimeline(sinceID : NSString = "") {
        println("load home timeline since \(sinceID)")
        SVProgressHUD.show()
        User.currentUser?.homeTimelineWithCompletion(sinceID : sinceID) {
            (tweets: [Tweet]?, error: NSError?) in
            if error == nil {
                if self.tweets?.count != 0 {
                    var arr = tweets! + self.tweets!
                    self.tweets = arr
                } else {
                    self.tweets = tweets
                }
                self.tabView.reloadData()
                self.refreshControl?.endRefreshing()
            } else {
                //handle getting hometimeline error
            }
        }
        SVProgressHUD.dismiss()
    }
    
    //redux stuff
   
    func viewDidLoadRedux() {
        println("view did load redux")

        sideBar = SideBar(sourceView: self.view!, menu:menu)
        sideBar!.delegate = self
        
        self.addChildViewController(sideBar!.sideBarTableViewController);
        sideBar!.sideBarTableViewController.didMoveToParentViewController(self);
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        println("side bar did select \(menu[index])")
        transitionToViewController(menu[index])
    }
    
    func transitionToViewController(menuItem: NSString) {
        
        if menuItem == "Home" {
            sideBar?.showSideBar(false)
            loadHomeTimeline(sinceID: self.tweets![0].tweetID!)
        }
        else if menuItem == "Profile" {
            self.performSegueWithIdentifier("gotoprofile", sender: self)
        }
        else if menuItem == "Mentions" {
            
        }
    }
   
}
