//
//  Episode.swift
//  rickAndMorty
//
//  Created by Ксения Шилина on 09.11.2023.
//

import Foundation

struct EpisodesResults: Codable {
    let results: [Episode]
}
struct Episode: Codable {
    let id: Int
    let name: String
    let episode: String
    
    let url: String
    
    var like : Bool?
    let characters: [String]
    

}

