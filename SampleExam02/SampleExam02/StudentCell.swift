//
//  StudentCell.swift
//  SampleExam02
//
//  Created by Prashanthi Rayala on 11/13/23.
//

import UIKit

class StudentCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
    
    
    @IBOutlet weak var titleLBL: UILabel!
    
    
    @IBOutlet weak var subtitleLBL: UILabel!
    

    @IBOutlet weak var studentIV: UIImageView!
    
    
}
