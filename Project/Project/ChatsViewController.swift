//
//  ChatsViewController.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/18/23.
//

import UIKit

class ChatsViewController: UIViewController {
    @IBOutlet weak var ChatsTable: UITableView!
    var Uemail = ""
    var chatData: [[String: Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchChats()
        ChatsTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let transition = segue.identifier
        if transition == "thisChat"{
            let destination = segue.destination as! ThisChatViewController
            if let selectedCell = sender as? ChatTableViewCell {
                           // Assuming you want to pass the text from the 'fromLabel' in the selected cell
                           if let text = selectedCell.fromLabel?.text {
                               destination.thisData = text
                               destination.logedInUser = Uemail
                           }
                         
                       }
        }
        else {
            print(Uemail)
            print("asdfa")
            let destination = segue.destination as! ViewController
            
            destination.loggedInUser = Uemail
        }
        
    }
    
  
    func fetchChats() {
        let url = URL(string: Server.chatsURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let email = Uemail
        let parameters: [String: Any] = ["email": email]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            print("Error encoding request parameters: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error making the request: \(error)")
            } else if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let chats = json["chats"] as? [[String: Any]] {
                        // Assuming you have a chatData array in your view controller
                        // You should populate this array with chat data
                        
                        self.chatData = chats
                        // Now, reload the table view on the main thread
                        DispatchQueue.main.async {
                            self.ChatsTable.reloadData()
                        }
                    }
                } catch {
                    print("Error parsing the response: \(error)")
                }
            }
        }

        task.resume()
    }


    // Call the fetchChats function
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   

}
extension ChatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of chat items in your chatData array
        return chatData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        // Configure the cell with chat data from chatData[indexPath.row]
        // For example: cell.textLabel?.text = chatData[indexPath.row]["message"]
        let chat = chatData[indexPath.row]
          
          // Access the UILabel in your custom cell (assuming it's named "fromLabel" in your ChatTableViewCell)
          let fromLabel = cell.fromLabel
          		
          // Set the text of the UILabel with the "from" value from the chat data
        fromLabel?.text = chat["_id"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          // Retrieve the selected user's email from your data source (e.g., userData)
          let selectedUserEmail = Uemail // Adjust the key as per your user data structure

          // Perform the segue to ThisChatViewController
          performSegue(withIdentifier: "thisChat", sender: selectedUserEmail)
      }
}
