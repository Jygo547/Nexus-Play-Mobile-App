//
//  GameTitle.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 10/26/23.
//

import Foundation

struct GameTitle: Identifiable, Decodable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "appid"
        case name
    }
}
