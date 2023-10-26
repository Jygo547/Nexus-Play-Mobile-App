//
//  GameTitleAPI.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 10/26/23.
//

import Foundation

struct GameTitleAPI {
    static let baseURL = "https://api.steampowered.com/ISteamApps/GetAppList/v2/"
    static let authKey = "BCD7B1785EFCBB750C300B19C4BA6764"

    static func fetchGameTitles(completion: @escaping ([GameTitle]) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion([])
            return
        }

        var request = URLRequest(url: url)
        request.setValue(authKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(AppListResponse.self, from: data)
                completion(decodedResponse.applist.apps)
            } catch {
                completion([])
            }
        }.resume()
    }

    private struct AppListResponse: Decodable {
        let applist: AppList
    }

    private struct AppList: Decodable {
        let apps: [GameTitle]
    }
}

