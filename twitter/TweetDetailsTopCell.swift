//
//  TweetDetailsTopCell.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetDetailsTopCell: UITableViewCell {

   
    //@IBOutlet weak var retweetUserLabel: UILabel!
    //@IBOutlet weak var retweetUserImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileScreenName: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var retweetTweetImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    
    func loadCellContents(tweet: Tweet) {
        
        //profile image
        setProfileImage(tweet.user?.profileImageURL)
        
        //labels
        profileNameLabel.text = tweet.user!.name
        profileScreenName.text = "@\(tweet.user!.screenName!)"
        tweetLabel.text = tweet.text
        
        //images
        favoriteImage.image = (tweet.favorited! == 0) ? ImageAssets.Instance.defaultFavoriteImage!.image :ImageAssets.Instance.onFavoriteImage!.image
        favoriteImage.accessibilityIdentifier = (tweet.favorited! == 0) ? "default" : "on"
        
        replyImage.image = ImageAssets.Instance.defaultReplyImage!.image
        
        retweetTweetImage.image = (tweet.retweeted! == 0)  ? ImageAssets.Instance.defaultRetweetImage!.image : ImageAssets.Instance.onRetweetImage!.image
        retweetTweetImage.accessibilityIdentifier = (tweet.retweeted! == 0) ? "default" : "on"
        
        //retweetUserImage.image = ImageAssets.Instance.defaultRetweetImage!.image

        //favorite and retweet counts
        favoritesLabel.text = "\(tweet.favoriteCount!.description) favorites"
        retweetsLabel.text = "\(tweet.retweetCount!.description) retweets"
    }
    
    func setProfileImage(imageURL: NSString!) {
        let url = NSURL(string: imageURL!)
        let url_request = NSURLRequest(URL: url!)
        self.profileImage.setImageWithURL(url)
    }
    
    override  func layoutSubviews() {
        super.layoutSubviews()
        self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width
    }
    

}
