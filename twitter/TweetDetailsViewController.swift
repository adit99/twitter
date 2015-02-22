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
        self.tabView.rowHeight = UITableViewAutomaticDimension
        
        //register tweet cell
        let nib = UINib(nibName: "TweetDetailsTopCell", bundle: NSBundle.mainBundle())
        self.tabView.registerNib(nib, forCellReuseIdentifier: "TweetDetailsTopCell")
        
        
        //clear row line separators
        self.tabView.separatorColor = UIColor.clearColor()
        
        //tap gestures
       
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetDetailsTopCell") as TweetDetailsTopCell
        cell.loadCellContents(self.tweet!)
        var tap = UITapGestureRecognizer(target: self, action: "replyTapped")
        //tap.delegate = self
        cell.replyImage.addGestureRecognizer(tap)
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("number of rows in section")
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected row")
        
    }

    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func replyTapped() {
        println("tapped")
    }

}
