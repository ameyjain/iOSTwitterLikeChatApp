//
//  TweetViewCell.swift
//  
//
//  Created by Amey Jain on 5/30/15.
//
//

import UIKit

class TweetViewCell: UITableViewCell {
    @IBOutlet var composetext: UITextView! = UITextView()
    @IBOutlet var usernamelabel: UILabel! = UILabel()
    @IBOutlet var timestamp: UILabel! = UILabel()
    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
