//
//  studentVCViewController.swift
//  prtactice2
//
//  Created by Prashanthi Rayala on 11/13/23.
//

import UIKit

class studentVC: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var underGradStudents = Student.undgData()
    var gradStudents = Student.gradData()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0 :
            return underGradStudents.count
        default :
            return gradStudents.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
        case 0 :
            let row = tableView.dequeueReusableCell(withIdentifier: "ugCell", for: indexPath)
            let student = underGradStudents[indexPath.row]
            row.textLabel?.text = student.fullName
            row.detailTextLabel?.text = "Started: \(student.startMonth)/\(student.startYear)     Transfer Credits: \(student.transferCredits)"
            return row
        case 1 :
            let row = tableView.dequeueReusableCell(withIdentifier: "gradCell", for: indexPath)
            let student = gradStudents[indexPath.row]
            row.textLabel?.text = student.fullName
            row.detailTextLabel?.text = "Started: \(student.startMonth)/\(student.startYear)     Transfer Credits: \(student.transferCredits)"
            return row
        default :
            break
        }
        return UITableViewCell()
    }
    
    
   
    

   
    @IBOutlet weak var studentsTV: UITableView!
    override func viewDidLoad() {
        
        
        

        super.viewDidLoad()

      
        self.navigationItem.title = "Students"
        
        self.studentsTV.delegate = self
        self.studentsTV.dataSource = self
        
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.performSegue(withIdentifier: "student", sender: indexPath)
        }
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let segueName = segue.identifier
            
            switch segueName {
            case "student" :
                if  let dest = segue.destination as? ProfileVC{
                    let idxPath = sender as! IndexPath
                    if idxPath.section == 0{
                        dest.student = underGradStudents[idxPath.row]
                        dest.isUndergrad = true
                    }else{
                        dest.student = gradStudents[idxPath.row]
                        dest.isUndergrad = false
                    }
                }
            default:
                break
            }}
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

