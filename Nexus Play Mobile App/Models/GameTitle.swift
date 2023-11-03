//
//  GameTitle.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 10/26/23.
//

import Foundation

struct GameTitle: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
    }
}

struct GameTitleResponse: Decodable {
    let results: [GameTitle]
}
