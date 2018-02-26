//
//  InstagramHomeViewController.swift
//  Instagram-01
//
//  Created by Anish Adhikari on 2/22/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit
import Parse

class InstagramHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var insta_posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView.rowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400
        
        // Magic code to fix headers
        let dummyViewHeight = CGFloat(40)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: dummyViewHeight))
        tableView.contentInset = UIEdgeInsetsMake(-dummyViewHeight, 0, 0, 0)
        
        refreshControl.addTarget(self, action: #selector(self.refreshPostsAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)

        let logo = UIImage(named: "instagram_logo_resized")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        // Do any additional setup after loading the view.
        loadPhotosFromParse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshPostsAction(_ refreshControl: UIRefreshControl) {
        loadPhotosFromParse()
        
    }
    
    func loadPhotosFromParse() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if posts != nil {
                self.insta_posts = posts as! [Post]
                print(self.insta_posts)
            } else {
                print("Failed to get posts")
            }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
 
    }
    
    @IBAction func logOutUser(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print (insta_posts.count)
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return insta_posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.post = self.insta_posts[indexPath.section]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 80))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
  
        let profileView = UIImageView(frame: CGRect(x: 15, y: 10, width: 50, height: 50))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 25;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        profileView.image = UIImage(named: "avatar")
        
        // Set the avatar
        
        headerView.addSubview(profileView)

        let profileNameView = UILabel(frame: CGRect(x: 75, y: 25, width:200, height:20))
        profileNameView.adjustsFontSizeToFitWidth = true
        profileNameView.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        
        let post = insta_posts[section]
        
        //var query = PFQuery()
        //var userAgain = query.getObjectWithId(user.objectId) as PFUser
        
        let query = PFUser.query()
        
        do {
            let user = try query?.getObjectWithId(post.author.objectId!)
            profileNameView.text = user?.object(forKey: "username") as? String
        } catch {
            print(error)
        }
       
        
        headerView.addSubview(profileNameView)
        
        /* Publish Dates
        let publishDateView = UILabel(frame: CGRect(x: 200, y: 30, width:200, height:20))
        publishDateView.adjustsFontSizeToFitWidth = true
        
         
        //let date = Date(timeIntervalSince1970: post.createdAt as! TimeInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "ET")
        dateFormatter.dateFormat = "MMM dd, HH:mm"
        let strDate = dateFormatter.string(from: post.createdAt!)
        
        publishDateView.text = strDate
        
        headerView.addSubview(publishDateView)
        */
        
        return headerView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
