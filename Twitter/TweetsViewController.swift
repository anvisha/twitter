//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/4/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tweetsView: UITableView!
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var labelTweetPosted: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTweetPosted.hidden = true
        
        tweetsView.delegate = self
        tweetsView.dataSource = self
        
        tweetsView.rowHeight = UITableViewAutomaticDimension
        tweetsView.estimatedRowHeight = 120
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "fetchHomeTimeline", forControlEvents: UIControlEvents.ValueChanged)
        
        let dummyTableVC = UITableViewController()
        dummyTableVC.tableView = tweetsView
        dummyTableVC.refreshControl = refreshControl
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "tweetPosted", name: tweetPostedNotification, object: nil)
        
        fetchHomeTimeline()

    }
    
    func fetchHomeTimeline() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tweetsView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func tweetPosted() {
        labelTweetPosted.hidden = false
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tweetsView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return (tweets?.count)!
        } else {
            return 0
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! TweetDetailViewController
        let indexPath = tweetsView.indexPathForCell(sender as! UITableViewCell)
        let selectedTweet = tweets![indexPath!.row]
        vc.selectedTweet = selectedTweet
    }

}
