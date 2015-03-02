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
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    
    var viewCenter : CGPoint!

    
    var tweets : [Tweet]?
    var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        user.userTimelineWithCompletion(sinceID : "") {
            (tweets: [Tweet]?, error: NSError?) in
            if error == nil {
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
        
        userName.text = user.name!
        screenName.text = "@\(user.screenName!)"
        
        
        //followersLabel.text = toString(user.followersCount!)
        followersLabel.text = numberToDisplay(user.followersCount!)
        
        //followingLabel.text = toString(user.followingCount!)
        followingLabel.text = numberToDisplay(user.followingCount!)

        //tweetsLabel.text = toString(user.tweets!)
        tweetsLabel.text = numberToDisplay(user.tweets!)
    
        //background image
        let background_url = NSURL(string: user.backgroundImageURL!)
        self.backgroundImageView.setImageWithURL(background_url)
        
        //profile image
        let profile_url = NSURL(string: user.profileImageURL!)
        self.profileImageView.setImageWithURL(profile_url)
        
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
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

    @IBAction func onPage(sender: UIPageControl) {
        
        
        if sender.currentPage == 1 {

            let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
            blurView.frame = backgroundImageView.bounds
            backgroundImageView.addSubview(blurView)
        }
        
            
        self.userName.fadeOut(completion: {
            (finished: Bool) -> Void in
            if sender.currentPage == 1 {
                let contextLabel = ContextLabel()
                contextLabel.text = self.user.tagLine!
                self.userName.attributedText = contextLabel.attributedText
                self.userName.font = UIFont.systemFontOfSize(14.0)

                let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
                blurView.frame = self.backgroundImageView.bounds
                self.backgroundImageView.addSubview(blurView)
                
            } else if sender.currentPage == 0 {
                self.userName.text = self.user.name!
                for view in self.backgroundImageView.subviews {
                    view.removeFromSuperview()
                }
                
            }
            self.userName.fadeIn()
        })
        
        self.screenName.fadeOut(completion: {
            (finished: Bool) -> Void in
            if sender.currentPage == 1 {
                
                self.screenName.text = self.user.location!
            } else if sender.currentPage == 0 {
                self.screenName.text = "@\(self.user.screenName!)"
            }
            self.screenName.fadeIn()
        })
    }
    
    /*@IBAction func onViewPan(panGestureRecognizer: UIPanGestureRecognizer) {
        
        var point = panGestureRecognizer.locationInView(self.view)
        var traslation = panGestureRecognizer.translationInView(self.view)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            println("Gesture began at: \(point)")
            viewCenter = view.center
            
        } else if panGestureRecognizer.state ==
            
            UIGestureRecognizerState.Changed {
                println("Gesture changed at: \(point)")
                view.center = CGPoint(x: viewCenter.x, y: viewCenter.y + traslation.y)
                
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            println("Gesture ended at: \(point)")
            
        }
    }*/


    func numberToDisplay(count : Int) -> NSString {
        
        println(count)
        switch count {
        case 0...999:
            return toString(count)
        case 1000...999999:
            let num = count/1000
            return "\(num)k"
        case 1,000,000...999999999:
            let num = count/1000000
            return "\(num)m"
        default:
            return toString(count)
        }
        
    }
    
}
