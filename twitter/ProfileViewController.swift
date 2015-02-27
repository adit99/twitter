//
//  ProfileViewController.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/26/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var tweets : [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        User.currentUser?.userTimelineWithCompletion(sinceID : "") {
            (tweets: [Tweet]?, error: NSError?) in
            if error == nil {
                println(tweets)
                self.tweets = tweets!
                self.tableView.reloadData()
            } else {
                //handle getting user error
            }
        }
        
        //register tweet cell
        let nib = UINib(nibName: "TweetViewCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(nib, forCellReuseIdentifier: "TweetViewCell")
        
        //labels
        followersLabel.text = toString(User.currentUser!.followersCount!)
        followingLabel.text = toString(User.currentUser!.followingCount!)
        tweetsLabel.text = toString(User.currentUser!.tweets!)
    
        //background image
        let background_url = NSURL(string: User.currentUser!.backgroundImageURL!)
        self.backgroundImageView.setImageWithURL(background_url)
        
        //profile image
        let profile_url = NSURL(string: User.currentUser!.profileImageURL!)
        self.profileImageView.setImageWithURL(profile_url)
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("profile cell for row")
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetViewCell") as TweetViewCell
        cell.loadCellContents(self.tweets![indexPath.row])
        
        /*ImageAssets.Instance.addTapGestureForImageView(&(cell.replyImage!), target: self, selector: "replyTapped:")
        cell.replyImage!.tag = indexPath.row
        
        ImageAssets.Instance.addTapGestureForImageView(&(cell.favoriteLabel!), target: self, selector: "favoriteTapped:")
        cell.favoriteLabel!.tag = indexPath.row
        
        ImageAssets.Instance.addTapGestureForImageView(&(cell.retweetImage!), target: self, selector: "retweetTapped:")
        cell.retweetImage!.tag = indexPath.row*/
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweetsArray = self.tweets  {
            return tweetsArray.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

}
