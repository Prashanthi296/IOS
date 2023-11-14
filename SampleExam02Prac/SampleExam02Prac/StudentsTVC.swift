//
//  StudentsTVC.swift
//  SampleExam02Prac
//
//  Created by Prashanthi Rayala on 11/13/23.
//

import UIKit

class StudentsTVC: UIViewController,  {
    
    
    
    @IBOutlet weak var studentTV: UITableView!
    
    let data = [["shiva", "konda"], ["prashanthi", "Rayala"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
