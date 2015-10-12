//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Anvisha Pai on 10/11/15.
//  Copyright © 2015 Anvisha Pai. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var profileTableView: UITableView!
    var activeUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()
//        activeUser = User.currentUser
        profileTableView.dataSource = self
        profileTableView.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = profileTableView.dequeueReusableCellWithIdentifier("ProfileHeaderCell", forIndexPath: indexPath) as! ProfileHeaderCell
            cell.activeUser = activeUser
            return cell
        
        }
        else {
            let cell = profileTableView.dequeueReusableCellWithIdentifier("ProfileStatsCell", forIndexPath: indexPath) as! ProfileStatsCell
            cell.activeUser = activeUser
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
