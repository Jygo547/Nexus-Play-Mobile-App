//
//  GameTitleAPI.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 10/26/23.
//

import Foundation

class GameTitleAPI {
    static let shared = GameTitleAPI()
    private let baseURL = "https://api.rawg.io/api/games"
    private let apiKey = "58cd0b7f651f43f39a9bc30c5994b3e3"
    
    func fetchGameTitles(completion: @escaping (Result<[GameTitle], Error>) -> Void) {
        let url = "\(baseURL)?key=\(apiKey)&dates=2019-09-01,2019-09-30&platforms=18,1,7"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if let data = data {
                do {
                    let gameTitles = try JSONDecoder().decode(GameTitleResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(gameTitles.results))
                    }
                    print(gameTitles.results)
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    print("Decoding error: \(error)")
                }

            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}



