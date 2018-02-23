//
//  InstagramHomeViewController.swift
//  Instagram-01
//
//  Created by Anish Adhikari on 2/22/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit

class InstagramHomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let logo = UIImage(named: "instagram_logo_resized")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutUser(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
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
