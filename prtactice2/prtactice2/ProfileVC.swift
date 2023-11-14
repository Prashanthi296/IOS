//
//  ProfileVC.swift
//  prtactice2
//
//  Created by Prashanthi Rayala on 11/13/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileIV: UIImageView!
    
    @IBOutlet weak var fullNameLBL: UILabel!
    

    @IBOutlet weak var transferCreditsLBL: UILabel!
    
    
    @IBOutlet weak var earliestGradLBL: UILabel!
    
    
    
    @IBOutlet weak var latestGradLBL: UILabel!
    
    
    var student: Student?
    
    var isUndergrad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Student Dashboard"
        
        fullNameLBL.text = self.student?.fullName
        transferCreditsLBL.text = "\(self.student.transferCredits)"
        anticipatedGraduation()
    }
    
    func anticipatedGraduation(){
        
        if isUndergrad{
            let diff = UtilityConstants.underGradTotal - self.student!.transferCredits
            let earliest = ceil(diff / UtilityConstants.underGradMax)
            self.earliestGradLBL.text = "\(earliest) semesters exluding summer semesters."
            let latest = ceil(diff / UtilityConstants.underGradMin)
            self.latestGradLBL.text = "\(latest) semesters exluding summer semesters."
        }else{
            let diff = UtilityConstants.gradTotal - self.student!.transferCredits
            let earliest = ceil(diff / UtilityConstants.gradMax)
            self.earliestGradLBL.text = "\(earliest) semesters exluding summer semesters."
            let latest = ceil(diff / UtilityConstants.gradMin)
            self.latestGradLBL.text = "\(latest) semesters exluding summer semesters."
        }
    }
}
