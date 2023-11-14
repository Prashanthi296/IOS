//
//  ViewController.swift
//  SampleExam02
//
//  Created by Prashanthi Rayala on 11/13/23.
//

import UIKit

class StudentsTVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var selectedStudent: Student = Student(fullName: " ", transferCredits: 0, startYear: 0, startMonth: 0)
    var flag:Int = -1
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
    return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){
            return "Under Graduate"
        } else{
            return "Graduate"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return undergrads.count
        } else {
            return grads.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if(section == 0){
            let cell = self.studentsTV.dequeueReusableCell(withIdentifier: "undergrads",for : indexPath )as! StudentCell
            cell.titleLBL?.text = undergrads[indexPath.row].fullName
            cell.subtitleLBL?.text = "Started: \(undergrads[indexPath.row].startMonth)/\(undergrads[indexPath.row].startYear)\t Transfer Credits: \(undergrads[indexPath.row].transferCredits)"
            return cell
        
        } else{
            let cell = self.studentsTV.dequeueReusableCell(withIdentifier: "grads",for : indexPath )as! StudentCell
            cell.titleLBL?.text = grads[indexPath.row].fullName
            cell.subtitleLBL?.text = "Started: \(grads[indexPath.row].startMonth)/\(grads[indexPath.row].startYear)\t Transfer Credits: \(grads[indexPath.row].transferCredits)"
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        
        if(section == 0){
            self.selectedStudent = undergrads[indexPath.row]
            self.flag = 0
            
        } else{
            
            self.selectedStudent = grads[indexPath.row]
            self.flag = 1
        }
        performSegue(withIdentifier: "displayProfile", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.studentsTV.dataSource = self
        self.studentsTV.delegate = self
    }

    
    @IBOutlet weak var studentsTV: UITableView!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, !identifier.isEmpty, identifier == "displayProfile"
        else {
            return
        }
        let destinationVC = segue.destination as! ProfileVC
        destinationVC.studentProfile = self.selectedStudent
        destinationVC.isGradOrUnderGrad = self.flag
        
    }
    
    
    
    
    
    
    

}

