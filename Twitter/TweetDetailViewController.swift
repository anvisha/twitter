//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/4/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {
    var selectedTweet: Tweet?
    @IBOutlet weak var tweetTableView: UITableView!
    var replyTweetId: String?
    var replyScreenName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 120

        tweetTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = selectedTweet
        cell.delegate = self
        return cell
    }

    @IBAction func backButtonClicked(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func replyClicked(tweet: Tweet) {
        print("registered")
        replyTweetId = tweet.id
        replyScreenName = tweet.user?.screenname
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ComposeTweetViewController
        vc.replyTweet = replyTweetId
        vc.replyScreenName = replyScreenName
    }

}
