//
//  DashViewController.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/18/23.
//

import UIKit

class DashViewController: UIViewController {
    @IBOutlet weak var TempL: UILabel!
    
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print("printing user")
       
        print("\(email) is the temp")
        TempL.text = email
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let transition = segue.identifier
        if transition == "chats"{
            let destination = segue.destination as! ChatsViewController
            destination.Uemail = email
            
        }
    }   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
