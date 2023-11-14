//
//  ProfileVC.swift
//  SampleExam02
//
//  Created by Prashanthi Rayala on 11/13/23.
//

import UIKit

class ProfileVC: UIViewController {
    var studentProfile: Student = Student(fullName: " ", transferCredits: 0, startYear: 0, startMonth: 0)
    var isGradOrUnderGrad : Int = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.fullNameLBL.text = self.studentProfile.fullName
        self.transferCreditsLBL.text = "\(self.studentProfile.transferCredits)"
         calculateCredits()
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var profileIV: UIImageView!
    
   
    @IBOutlet weak var fullNameLBL: UILabel!
    
    @IBOutlet weak var transferCreditsLBL: UILabel!
    
  
    @IBOutlet weak var earliestGradLBL: UILabel!
    
    
    @IBOutlet weak var latestGradLBL: UILabel!
    
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func calculateCredits(){
        if(self.isGradOrUnderGrad == 0)
        {
            let outStandingCredits = UtilityConstants.underGradTotal - self.studentProfile.transferCredits
            let earliestGraduation = ceil(outStandingCredits/UtilityConstants.underGradMax)
            self.earliestGradLBL.text = "\(earliestGraduation)"
            
            let latestGraduation = ceil(outStandingCredits/UtilityConstants.underGradMin)
            self.latestGradLBL.text = "\(latestGraduation)"
        } else{
            
            let outStandingCredits = UtilityConstants.gradTotal - self.studentProfile.transferCredits
            let earliestGraduation = ceil(outStandingCredits/UtilityConstants.gradMax)
            self.earliestGradLBL.text = "\(earliestGraduation)"
            
            let latestGraduation = ceil(outStandingCredits/UtilityConstants.gradMin)
            self.latestGradLBL.text = "\(latestGraduation)"
        }
        
    }
}
