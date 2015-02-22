//
//  TweetDetailsViewController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetDetailsViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tabView: UITableView!
    var tweet : Tweet?
    var tapCtrl : TapGestureController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //autolayout
        self.tabView.estimatedRowHeight = 220
        self.tabView.rowHeight = UITableViewAutomaticDimension
        
        //register tweet cell
        let nib = UINib(nibName: "TweetDetailsTopCell", bundle: NSBundle.mainBundle())
        self.tabView.registerNib(nib, forCellReuseIdentifier: "TweetDetailsTopCell")
        
        //clear row line separators
        self.tabView.separatorColor = UIColor.clearColor()
        
        //Tap gestures
        tapCtrl = TapGestureController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetDetailsTopCell") as TweetDetailsTopCell
        cell.loadCellContents(self.tweet!)
        
        /*tapCtrl!.addTapGestureForImageViews(&(cell.replyImage!), retweetView: &(cell.retweetTweetImage!), favoriteView: &(cell.favoriteImage!))*/
        
        ImageAssets.Instance.addTapGestureForImageView(&(cell.replyImage!), target: self, selector: "replyTapped:")
        
        ImageAssets.Instance.addTapGestureForImageView(&(cell.favoriteImage!), target: self, selector: "favoriteTapped:")
        
        ImageAssets.Instance.addTapGestureForImageView(&(cell.retweetTweetImage!), target: self, selector: "retweetTapped:")
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("number of rows in section")
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected row")
        self.tabView.deselectRowAtIndexPath(indexPath, animated: true)

    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func replyTapped(gesture: UITapGestureRecognizer) {
        println("reply tapped")
    }
    
    func retweetTapped(gesture: UITapGestureRecognizer) {
        println("retweet tapped")
        tapCtrl!.handleRetweet(gesture, sender: self, tweet: tweet!)
    }
    
    func favoriteTapped(gesture: UITapGestureRecognizer) {
        println("favorite tapped")
        tapCtrl!.handleFavorite(gesture, sender: self, tweet: tweet!)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(tableView: UITableView, estimateHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 220
    }
}
