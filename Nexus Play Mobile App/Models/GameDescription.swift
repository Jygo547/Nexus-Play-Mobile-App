//
//  File.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/9/23.
//

import Foundation

struct GameDescription: Decodable {
    let id: Int
    let name: String
    let description: String
    let released: String
    let backgroundImage: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, released
        case backgroundImage = "background_image"
        case rating
    }
}

