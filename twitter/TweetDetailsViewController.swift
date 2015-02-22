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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetDetailsTopCell") as TweetDetailsTopCell
        cell.loadCellContents(self.tweet!)
        
        var tap = UITapGestureRecognizer(target: self, action: "replyTapped:")
        tap.cancelsTouchesInView = true
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        cell.replyImage.userInteractionEnabled = true
        cell.replyImage.addGestureRecognizer(tap)
        
        var tap2 = UITapGestureRecognizer(target: self, action: "retweetTapped:")
        tap2.cancelsTouchesInView = true
        tap2.numberOfTapsRequired = 1
        tap2.numberOfTouchesRequired = 1
        cell.retweetTweetImage.userInteractionEnabled = true
        cell.retweetTweetImage.addGestureRecognizer(tap2)
        
        var tap3 = UITapGestureRecognizer(target: self, action: "favoriteTapped:")
        tap3.cancelsTouchesInView = true
        tap3.numberOfTapsRequired = 1
        tap3.numberOfTouchesRequired = 1
        cell.favoriteImage.userInteractionEnabled = true
        cell.favoriteImage.addGestureRecognizer(tap3)
        
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
        println("tapped")
    }
    
    func retweetTapped(gesture: UITapGestureRecognizer) {
        println("tapped")
    }
    
    func favoriteTapped(gesture: UITapGestureRecognizer) {
        println("tapped")
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(tableView: UITableView, estimateHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 220
    }
}
