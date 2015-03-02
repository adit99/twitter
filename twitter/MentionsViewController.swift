//
//  MentionsViewController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 3/1/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MentionsViewController: UITableViewController {

    var tweets : [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register tweet cell
        let nib = UINib(nibName: "TweetViewCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(nib, forCellReuseIdentifier: "TweetViewCell")
        
        User.currentUser!.mentionsTimelineWithCompletion() {
            (tweets: [Tweet]?, error: NSError?) in
            if error == nil {
                self.tweets = tweets!
                self.tableView.reloadData()
            } else {
                //handle getting user error
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweetsArray = self.tweets  {
            println(tweetsArray.count)
            return tweetsArray.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetViewCell") as TweetViewCell
        cell.loadCellContents(self.tweets![indexPath.row])
        return cell
    }

    

}
