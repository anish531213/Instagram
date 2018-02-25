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
        print (insta_posts.count)
        return insta_posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.post = self.insta_posts[indexPath.row]
        
        return cell
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
