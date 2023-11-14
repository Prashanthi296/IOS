//
//  ChatTableViewCell.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/19/23.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    var from = ""
    @IBOutlet weak var fromLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
        // Configure the view for the selected state
    }

}
