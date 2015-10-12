//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/4/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellDelegate {
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var tweetsView: UITableView!
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var labelTweetPosted: UILabel!
    var replyTweetId: String?
    var replyScreenName: String?
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    var menuPositionWhenOpen: CGPoint?
    var menuPositionWhenClosed: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTweetPosted.hidden = true
        
        tweetsView.delegate = self
        tweetsView.dataSource = self
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        tweetsView.rowHeight = UITableViewAutomaticDimension
        tweetsView.estimatedRowHeight = 120
        
        menuTableView.rowHeight = UITableViewAutomaticDimension
        menuTableView.estimatedRowHeight = 50
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "fetchHomeTimeline", forControlEvents: UIControlEvents.ValueChanged)
        
        menuPositionWhenOpen = menuView.center
        menuPositionWhenClosed = CGPoint(x: menuView.center.x - menuView.frame.width, y: menuView.center.y)
        print("hello")
        menuView.center = menuPositionWhenClosed!
        
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
        if tableView == tweetsView {
            let cell = tweetsView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
            cell.tweet = tweets![indexPath.row]
            cell.delegate = self
            return cell
        } else {
            if indexPath.section == 0 {
                let cell = menuTableView.dequeueReusableCellWithIdentifier("MenuHeaderCell", forIndexPath: indexPath) as! MenuHeaderCell
                return cell
            } else {
                let cell = menuTableView.dequeueReusableCellWithIdentifier("MenuItemCell", forIndexPath: indexPath) as! MenuItemCell
                cell.rowIndex = indexPath.row
                return cell
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == menuTableView {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tweetsView {
            if tweets != nil {
                return (tweets?.count)!
            } else {
                return 0
            }
        } else {
            if section == 0 {
                print("section 0")
                return 1
            }
            else{
                print("section 1")
                return 3
            }
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == menuTableView {
            if indexPath.section == 1 {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
                vc.activeUser = User.currentUser
                presentViewController(vc, animated: true, completion: { () -> Void in
                    //
                })
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func replyClicked(tweet: Tweet) {
        print("so this happened")
        replyTweetId = tweet.id
        replyScreenName = tweet.user?.screenname
        
    }
    
    
    @IBAction func onViewPanGesture(sender: UIPanGestureRecognizer) {
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            //began
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            //changed
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            let velocity = panGestureRecognizer.velocityInView(parentView)
            if velocity.x > 0 {
                //open menu
                menuView.center = menuPositionWhenOpen!
            } else {
                //close menu
                menuView.center = menuPositionWhenClosed!
            }
        } else {
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailsSegue" {
            let vc = segue.destinationViewController as! TweetDetailViewController
            let indexPath = tweetsView.indexPathForCell(sender as! UITableViewCell)
            let selectedTweet = tweets![indexPath!.row]
            vc.selectedTweet = selectedTweet
        }
        else if segue.identifier == "replySegue" {
            let vc = segue.destinationViewController as! ComposeTweetViewController
            vc.replyTweet = replyTweetId
            vc.replyScreenName = replyScreenName
        }
        else if segue.identifier == "timelineToProfile" {
            let vc = segue.destinationViewController as! ProfileViewController
            let indexPath = tweetsView.indexPathForCell(sender?.superview!!.superview as! UITableViewCell)
            let selectedTweetUser = tweets![(indexPath?.row)!].user
            vc.activeUser = selectedTweetUser
        }
    }
}
