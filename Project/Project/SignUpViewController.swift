//
//  SignUpViewController.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/17/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var ownSwtch: UISwitch!
    @IBOutlet weak var CPassField: UITextField!
    @IBOutlet weak var PassField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var NameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after     loading the view.
    }
    
    @IBAction func SignUpBtn(_ sender: Any) {
        let name = NameField.text!
        let pass = PassField.text!
        let cpass = CPassField.text!
        let email = EmailField.text!
      
        if( name.count <= 0 || pass.count <= 0   || cpass.count <= 0   || email.count <= 0 )
        {
            output.text = "Fill the details"
           
            NameField.layer.borderColor = UIColor.red.cgColor
            NameField.layer.borderWidth = 1.0 // You can adjust the width of the border as needed
            NameField.layer.cornerRadius = 5.0 // You can add rounded corners if desired
        }
        else if(pass != cpass)
        {
            output.text = "password doesnot match"
        }
        else if(!isValidEmail(email)){
            output.text = "Email is not valid"
        }
        else{
            NameField.layer.borderColor = nil
            NameField.layer.borderWidth = 0
            NameField.layer.cornerRadius = 0
            let data: [String: Any] = [
                "name": name,
                "password": pass,
                "email": email
            ]
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])

                
                let url = URL(string: Server.userURL+"singup" )!
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print("Error: \(error)")
                    } else {
                        	
                    }
                }
                task.resume()
            } catch {
                print("Error serializing data to JSON: \(error)")
            }
            
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

}
