//
//  TableViewCell.swift
//  SampleExam02Prac
//
//  Created by Prashanthi Rayala on 11/13/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var pImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
