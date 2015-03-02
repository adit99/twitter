//
//  TweetDetailsTopCell.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/21/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetDetailsTopCell: UITableViewCell, ContextLabelDelegate {

   
    //@IBOutlet weak var retweetUserLabel: UILabel!
    //@IBOutlet weak var retweetUserImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileScreenName: UILabel!
    
    //@IBOutlet weak var tweetLabel: UILabel!
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
        
        //tweet label with attributes
        let contextLabel = ContextLabel()
        contextLabel.text = tweet.text
        contextLabel.delegate = self
        tweetLabel.attributedText = contextLabel.attributedText

        //images
        favoriteImage.image = (tweet.favorited! == 0) ? ImageAssets.Instance.defaultFavoriteImage!.image :ImageAssets.Instance.onFavoriteImage!.image
        favoriteImage.highlighted = (tweet.favorited! == 0) ? false : true
        
        replyImage.image = ImageAssets.Instance.defaultReplyImage!.image
        
        retweetTweetImage.image = (tweet.retweeted! == 0)  ? ImageAssets.Instance.defaultRetweetImage!.image : ImageAssets.Instance.onRetweetImage!.image
        retweetTweetImage.highlighted = (tweet.retweeted! == 0) ? false : true
        
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
    
    func contextLabel(contextLabel: ContextLabel, beganTouchOf text: String, with linkRangeResult: LinkRangeResult) {
        //tweetLabel.text = "beganTouchOf: \(text)" + "\nRange: \(linkRangeResult.linkRange)"
        println("began touches of \(text)")
    }
    
    func contextLabel(contextLabel: ContextLabel, movedTouchTo text: String, with linkRangeResult: LinkRangeResult) {
        //tweetLabel.text = "movedTouchTo: \(text)" + "\nRange: \(linkRangeResult.linkRange)"
        println("movedTouchTo \(text)")
        
    }
    
    func contextLabel(contextLabel: ContextLabel, endedTouchOf text: String, with linkRangeResult: LinkRangeResult) {
        //tweetLabel.text = "endedTouchOf: \(text)" + "\nRange: \(linkRangeResult.linkRange)"
        println("endedTouchOf \(text)")
        
    }

}
