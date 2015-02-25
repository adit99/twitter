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
    
    //@IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tweetLabel: TTTAttributedLabel!
    
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
        favoriteImage.highlighted = (tweet.favorited! == 0) ? false : true
        
        replyImage.image = ImageAssets.Instance.defaultReplyImage!.image
        
        retweetTweetImage.image = (tweet.retweeted! == 0)  ? ImageAssets.Instance.defaultRetweetImage!.image : ImageAssets.Instance.onRetweetImage!.image
        retweetTweetImage.highlighted = (tweet.retweeted! == 0) ? false : true
        
        //retweetUserImage.image = ImageAssets.Instance.defaultRetweetImage!.image

        //favorite and retweet counts
        favoritesLabel.text = "\(tweet.favoriteCount!.description) favorites"
        retweetsLabel.text = "\(tweet.retweetCount!.description) retweets"
        
        /*tweetLabel.text = tweet.text
        tweetLabel.setText(<#text: AnyObject!#>, afterInheritingLabelAttributesAndConfiguringWithBlock: <#((NSMutableAttributedString!) -> NSMutableAttributedString!)!##(NSMutableAttributedString!) -> NSMutableAttributedString!#>)
        
        let linkColor = UIColor(red: 0.203, green: 0.329, blue: 0.835, alpha: 1)
        let linkActiveColor = UIColor.blackColor()
                
        tweetLabel.linkAttributes = [NSForegroundColorAttributeName : linkColor]
        tweetLabel.activeLinkAttributes = [NSForegroundColorAttributeName : linkActiveColor]
        tweetLabel.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue*/
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
