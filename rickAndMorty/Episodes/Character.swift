//
//  Character.swift
//  rickAndMorty
//
//  Created by Ксения Шилина on 10.11.2023.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let location: Location
    let origin: Origin
    
}
struct Origin: Codable {
    let name: String
    let url: String
}
struct Location: Codable {
    let name: String
    let url: String
}
