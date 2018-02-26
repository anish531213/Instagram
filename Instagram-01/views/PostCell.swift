//
//  PostCell.swift
//  Instagram-01
//
//  Created by Anish Adhikari on 2/25/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit
import ParseUI

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var postCationLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var post: Post! {
        didSet {
            self.postCationLabel.text = post.caption
            self.postImageView.file = post.media as PFFile
            self.postImageView.loadInBackground()
            self.timeStampLabel.text = convertDateToTimeStamp()
        }
    }
    
    func convertDateToTimeStamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "ET")
        dateFormatter.dateFormat = "MMM dd, HH:mm"
        let strDate = dateFormatter.string(from: post.createdAt!)
        //print(strDate)
        return strDate
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
