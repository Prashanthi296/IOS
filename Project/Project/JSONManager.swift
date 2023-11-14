//
//  JSONManager.swift
//  Project
//
//  Created by Prashanthi Rayala on 10/19/23.
//

import Foundation

// MARK: - WelcomeElement
struct ChatCon: Codable {
    let msg: String
    let isVoice: Bool
    let from, to, audioURL, id: String
    static let allChats:[ChatCon] = Bundle.main.decore(file: <#T##String#>)
    enum CodingKeys: String, CodingKey {
        case msg, isVoice, from, to, audioURL
        case id = "_id"
    }
}

extension Bundle{
    func decore<T:Decodable>(file:String)-> T{
        guard let url = self.url(forResource: file, withExtension: nil) else {
               fatalError("Could not find \(file) in bundle.")
           }
           
           guard let data = try? Data(contentsOf: url) else {
               fatalError("Could not load \(file) from bundle.")
           }
           
           let decoder = JSONDecoder()
           
           guard let loadedData = try? decoder.decode(T.self, from: data) else {
               fatalError("Could not decode \(file) from bundle.")
           }
           
           return loadedData
    }
}
