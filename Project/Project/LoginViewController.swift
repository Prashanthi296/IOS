//
//  LoginViewController.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/17/23.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var Email: UITextField!
    var userEmail: String?
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var Pass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LoginBTN(_ sender: Any) {
        let un = Email.text!
        let pass = Pass.text!
        if(loginToServer(email: un, password: pass)) {
          
                // Handle successful login, e.g., perform a segue
                print("Login successful")
            userEmail = un
           
            }
           else {
                // Handle login failure
                print("Login failed")
                let alert = UIAlertController(title: "Alert", message: "You have provided the wrong details", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
                self.present(alert,animated: true,completion: nil)
            }
        }
            
   

    func loginToServer(email: String, password: String) -> Bool {
        let urlString = "\(Server.loginURL)"
        
        guard let url = URL(string: urlString) else {
            return false
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = ["email": email, "password": password]
        print(parameters)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            print("Failed to encode JSON data")
            return false
        }
        
        var loginSuccessful = false
        
        let semaphore = DispatchSemaphore(value: 0) // Create a semaphore
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                loginSuccessful = false
            } else if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let user = try jsonDecoder.decode(User.self, from: data)
                    
                    // Assuming you have a User struct defined that matches the JSON structure
                    // Here, we've already decoded the user data
                    print("Authentication successful. Welcome, \(user.name)")
                    
                    // Check if the received object contains the necessary fields (e.g., "name" and "email")
                    if !user.name.isEmpty && !user.email.isEmpty {
                        loginSuccessful = true
                    } else {
                        loginSuccessful = false
                    }
                    
                } catch {
                    print("Failed to decode JSON data: \(error)")
                    loginSuccessful = false
                }
            }
            
            semaphore.signal() // Signal that the task is complete
        }

        
        task.resume()
        
        semaphore.wait() // Wait until the task is complete
        
        return loginSuccessful
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DashViewController, segue.identifier == "login" {
            if let userEmail = userEmail {
                destination.email = userEmail
            }
        }
    }
    }

        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


