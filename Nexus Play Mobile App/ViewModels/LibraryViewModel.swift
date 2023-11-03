//
//  LibraryViewModel.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 10/26/23.
//

import Foundation

import Combine

class LibraryViewModel: ObservableObject {
    @Published var gameTitles: [GameTitle] = []
    
    func fetchGameTitles() {
        GameTitleAPI.shared.fetchGameTitles { [weak self] result in
            switch result {
            case .success(let gameTitles):
                DispatchQueue.main.async {
                    self?.gameTitles = gameTitles
                }
            case .failure(let error):
                print("Error fetching game titles: \(error)")
            }
        }
    }
}

