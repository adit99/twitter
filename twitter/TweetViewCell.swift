//
//  TweetViewCell.swift
//  twitter
//
//  Created by Aditya Jayaraman on 2/19/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell, ContextLabelDelegate {

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
        createdAtLabel.text = Tweet.timeSinceTweet(tweet.createdAt!)
        
        //tweet label
        let contextLabel = ContextLabel()
        contextLabel.text = tweet.text
        contextLabel.delegate = self
        tweetLabel.attributedText = contextLabel.attributedText
        tweetLabel.font = UIFont.systemFontOfSize(12.0)
        
        //images
        favoriteLabel.image = (tweet.favorited! == 0) ? ImageAssets.Instance.defaultFavoriteImage!.image :ImageAssets.Instance.onFavoriteImage!.image
        favoriteLabel.highlighted = (tweet.favorited! == 0) ? false : true
        
        replyImage.image = ImageAssets.Instance.defaultReplyImage!.image
        
        retweetImage.image = (tweet.retweeted! == 0)  ? ImageAssets.Instance.defaultRetweetImage!.image : ImageAssets.Instance.onRetweetImage!.image
        retweetImage.highlighted = (tweet.retweeted! == 0) ? false : true
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
