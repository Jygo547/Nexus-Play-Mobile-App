//
//  GameDescriptionViewModel.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/9/23.
//

import Combine

import Foundation

class GameDescriptionViewModel: ObservableObject {
    @Published var gameDescriptions: [Int: GameDescription] = [:] // For multiple game descriptions
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // New method to fetch multiple game descriptions
    
    func fetchGameDescriptions(ids: [Int]) {
        isLoading = true
        let group = DispatchGroup()

        ids.forEach { id in
            group.enter()
            GameTitleAPI.shared.fetchGameDescription(id: id) { [weak self] result in
                DispatchQueue.main.async {
                    defer { group.leave() }
                    guard let strongSelf = self else { return }
                    switch result {
                    case .success(let description):
                        strongSelf.gameDescriptions[id] = description
                    case .failure(let error):
                        strongSelf.errorMessage = error.localizedDescription
                    }
                }
            }
        }

        group.notify(queue: .main) {
            [weak self] in
            self?.isLoading = false
        }
    }

}


