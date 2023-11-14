//
//  Misc.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/17/23.
//
import Foundation
struct User: Codable {
    let name: String
    let email: String
    // Add other properties as needed to match the JSON structure
}
struct ChatContent: Decodable {
    var _id: String
    var audioURL: String
    var from: String
    var isVoice: Bool
    var msg: String
    var to: String
}
struct Chat :Codable {
    var id: String
    var users: [String]
    var chatContent: [String]
    var __v: Int
}
struct Server {
    
    
    static let baseURL = "https://68e4-104-251-241-109.ngrok-free.app/"

    static let userURL = "\(baseURL)user/"
    static let loginURL = "\(userURL)login"
    static let chatsURL = "\(userURL)chats"
    static let chatURL = "\(baseURL)chat"
    static let staticURL = "\(baseURL)static"
    static let audioURL = "\(staticURL)/audio"
       // Add more server-related constants here
   }

