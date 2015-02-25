//
//  TweetViewCell.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/19/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var favoriteLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width
    }
    
    func loadCellContents(tweet: Tweet) {
        
        //profile image
        setProfileImage(tweet.user?.profileImageURL)
        
        //labels
        userLabel.text = tweet.user!.name
        handleLabel.text = "@\(tweet.user!.screenName!)"
        tweetLabel.text = tweet.text
        createdAtLabel.text = Tweet.timeSinceTweet(tweet.createdAt!)
        
        //images
        favoriteLabel.image = (tweet.favorited! == 0) ? ImageAssets.Instance.defaultFavoriteImage!.image :ImageAssets.Instance.onFavoriteImage!.image
        favoriteLabel.accessibilityIdentifier = (tweet.favorited! == 0) ? "default" : "on"
        
        replyImage.image = ImageAssets.Instance.defaultReplyImage!.image
        
        retweetImage.image = (tweet.retweeted! == 0)  ? ImageAssets.Instance.defaultRetweetImage!.image : ImageAssets.Instance.onRetweetImage!.image
        retweetImage.accessibilityIdentifier = (tweet.retweeted! == 0) ? "default" : "on"
    }
    
    func setProfileImage(imageURL: NSString!) {
        let url = NSURL(string: imageURL!)
        let url_request = NSURLRequest(URL: url!)
        self.profileImage.setImageWithURL(url)
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override  func layoutSubviews() {
        super.layoutSubviews()
        self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width
    }
    
}
