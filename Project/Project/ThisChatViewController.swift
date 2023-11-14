//
//  ThisChatViewController.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/19/23.
//

import UIKit
struct ChatCon :Hashable,Codable{
    var _id: String
    var audioURL: String
    var from: String
    var isVoice: Bool
    var msg: String
    var to: String
}
class ThisChatViewController: UIViewController {
    var thisData = ""
    var logedInUser = ""
    var chatData : [ChatCon] = []
    @IBOutlet weak var ThisChatTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        print("Thishcat in \(thisData)")
    fetchChats()
       
        ThisChatTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    func fetchChats() {
        guard let url = URL(string: Server.chatURL) else {
            print("Invalid URL: \(Server.chatURL)")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let documentID = thisData
        let parameters: [String: Any] = ["id": documentID]

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
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                      
                    let decoder = JSONDecoder()

                    do {
                        let chats = try JSONDecoder().decode([ChatCon].self, from: data)
                        print(chats)
                        chatData = chats
                        DispatchQueue.main.async {
                            self.ThisChatTable.reloadData()
                        }
                    } catch {
                        print("Error parsing the response: \(error)")
                    }
                                            
                } catch {
                    print("Error parsing the response: \(error)")
                }
            }
        }

        task.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let transition = segue.identifier
        if transition == "VoiceMSG"{
            let destination = segue.destination as! ViewController
            var tempFrom = chatData[0].from
            var tempTo = chatData[0].to
            var recep = ""
            if(tempFrom == logedInUser)
            {
                recep = tempTo
            }
            else{
                recep = tempFrom
            }
            destination.loggedInUser = logedInUser
            print("priting recep")
            print(recep)
            destination.SendtEmail = recep
           
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destination.
         Pass the selected object to the new view controller.
    }
    */

}
extension ThisChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of chat items in your chatData array
        print(chatData.count)
        return chatData.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ChatContentTableViewCell
        // Configure the cell with chat data from chatData[indexPath.row]
       
        let chat = chatData[indexPath.row]
          
          // Access the UILabel in your custom cell (assuming it's named "fromLabel" in your ChatTableViewCell)
          let fromLabel = cell.chatmsg
                  
          // Set the text of the UILabel with the "from" value from the chat data
        if(logedInUser == chat.from){
            cell.backgroundColor = UIColor.blue
        }
        else{
            cell.backgroundColor = UIColor.red
        }
        if(!chat.audioURL.isEmpty){
            cell.chatmsg.isHidden = false
            fromLabel?.isHidden = true
           
        }
        else{
     
            cell.audioBtn.isHidden = false
            cell.chatmsg.isHidden = true
            
            
        }
        print(chat)
        cell.audioURL = chat.audioURL
        cell.from = chat.from
        cell.to = chat.to
        cell.msg = chat.msg
        cell.isVoice = chat.isVoice
        cell.logedInUser = logedInUser
        return cell
    }
    
  
}
