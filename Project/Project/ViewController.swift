//
//  ViewController.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/16/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate  {
    @IBOutlet weak var stopBtn: UIButton!
    var Uemail = ""
    var loggedInUser = ""
    var SendtEmail = ""
    var audioRecorder: AVAudioRecorder?
    var audioURL: URL?
    var isRecording = false
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var StartBtn: UIButton!
    var soundRec = AVAudioRecorder()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Wesef")
        
        print(loggedInUser)
        print(SendtEmail)
        if(!SendtEmail.isEmpty){
            textField.text = SendtEmail
            textField.isEnabled = false
            StartBtn.isEnabled = true
            stopBtn.isEnabled = true
        }
        else{
            textField.isEnabled = true
           
        }
        configureAudioSession()
        // Do any additional setup after loading the view.
    }
    func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.record, mode: .default, options: [])
            try session.setActive(true)
            print("Audio session is fine")
        } catch {
            print("Error configuring audio session: \(error.localizedDescription)")
        }
    }
    @IBAction func stopRec(_ sender: Any) {
        stopRecording()
    }
  
  
    @IBAction func BtnClicked(_ sender: Any) {
      
    
        if(textField.isEnabled && textField.text!.isEmpty){
            print(SendtEmail)
          print("Email is empty")
            
        }
        else {
            SendtEmail = textField.text!
            print(SendtEmail)
            recordAudio()
//
//            let serverURL = URL(string: Server.baseURL)!
//
//
//            let task = URLSession.shared.dataTask(with: serverURL) { (data, response, error) in
//                if let error = error {
//                    print("Error: \(error)")
//                    return
//                }
//
//                guard let data = data else {
//                    print("No data received")
//                    return
//                }
//
//                // Handle the data from the response
//                do {
//                    let responseJSON = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(data)
//                    print("Response JSON: \(responseJSON)")
//                } catch {
//                    print("Error parsing JSON: \(error)")
//                }
//            }
//
//            task.resume()

        }

    }
    func recordAudio() {
        print("Recording started")
        if !isRecording {
            let audioFilename = getDocumentsDirectory().appendingPathComponent("audioFile.m4a")

            let settings: [String: Any] = [
                AVFormatIDKey: kAudioFormatAppleLossless,
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]

            do {
                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                audioRecorder?.delegate = self
                
                if audioRecorder?.prepareToRecord() == true {
                    audioRecorder?.record()
                    isRecording = true
                    updateUI()
                } else {
                    print("Error: Unable to prepare for recording")
                }
            } catch {
                print("Error starting recording: \(error.localizedDescription)")
            }
        }
    }
    func stopRecording() {
        if isRecording {
            audioRecorder?.stop()
            isRecording = false
            updateUI()
            
        }
    }

    func updateUI() {
       
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            audioURL = recorder.url
            print(audioURL!)
           

            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: audioURL!)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
            sendAudioToServer(audioURL: audioURL!,email1:loggedInUser,email2: SendtEmail)
            // Handle the recorded audio file here
        } else {
            print("Recording did not finish successfully")
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func sendAudioToServer(audioURL: URL,email1: String, email2: String) {
        // Create a URL request to your server's endpoint
        let boundary = "iyix"
        let serverURL = URL(string: Server.baseURL)!
        var request = URLRequest(url: serverURL)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                   request.httpMethod = "POST"
        var bodyData = Data()
        // Add email1 part
           bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
           bodyData.append("Content-Disposition: form-data; name=\"email1\"\r\n\r\n".data(using: .utf8)!)
           bodyData.append(email1.data(using: .utf8)!)
           bodyData.append("\r\n".data(using: .utf8)!)
           
           // Add email2 part
           bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
           bodyData.append("Content-Disposition: form-data; name=\"email2\"\r\n\r\n".data(using: .utf8)!)
           bodyData.append(email2.data(using: .utf8)!)
           bodyData.append("\r\n".data(using: .utf8)!)
         // Add the audio file part
         bodyData.append("--\(boundary)\r\n".data(using: .utf8)!)
         bodyData.append("Content-Disposition: form-data; name=\"audio\"; filename=\"audiofile.m4a\"\r\n".data(using: .utf8)!)
         bodyData.append("Content-Type: audio/m4a\r\n\r\n".data(using: .utf8)!)	
         bodyData.append(try! Data(contentsOf: audioURL))
         bodyData.append("\r\n".data(using: .utf8)!)
        bodyData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = bodyData
        // Create a data task to send the audio file
        URLSession.shared.dataTask(with: request) { data, response, error in
              if let error = error {
                  print("Error: \(error)")
              } else if let data = data {
                  let responseString = String(data: data, encoding: .utf8)
                  print("Response: \(responseString ?? "No response")")
                  // Handle the server's response here
              }
          }.resume()
    }
}

