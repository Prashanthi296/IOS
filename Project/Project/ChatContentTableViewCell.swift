//
//  ChatContentTableViewCell.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/19/23.
//

import UIKit
import AVFoundation
class ChatContentTableViewCell: UITableViewCell {
   
    var logedInUser = ""
    var audioURL = ""
    var msg = ""
    var from = ""
    var to = ""
    var isVoice = false
    
    @IBOutlet weak var audioBtn: UIButton!
    var chatCont:[ChatCon] = []
    @IBOutlet weak var chatmsg: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        
        // Initialization code
    }
    @IBAction func PlayAudio(_ sender: Any) {
        print(audioURL)
        let url = URL(string: Server.audioURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Replace audioURLValue with the actual audio URL you want to send.
        let audioURLValue = "https://example.com/audio.mp3"
        let parameters: [String: Any] = ["audioURL": audioURL]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                          let audioPlayer = try AVAudioPlayer(data: data)
                          audioPlayer.prepareToPlay()
                          audioPlayer.play()
                      } catch {
                          print("Error playing audio: \(error)")
                      }            }
        }

        task.resume()
    }
    
    func playAudio(data: Data) {
        do {
            let audioPlayer = try AVAudioPlayer(data: data)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("Error playing audio: \(error)")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }

}
