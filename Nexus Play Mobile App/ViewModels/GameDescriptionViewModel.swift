//
//  GameDescriptionViewModel.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/9/23.
//

import Combine

import Foundation

class GameDescriptionViewModel: ObservableObject {
    
    static let shared = GameDescriptionViewModel()
    
    @Published var gameDescriptions: [Int: GameDescription] = [:] // For multiple game descriptions
    @Published var cartItems: [Int: GameDescription] = [:]
    @Published var isLoading = false
    @Published var errorMessage: String?
//    private var loadedIds: Set<Int> = []
    
    // New method to fetch multiple game descriptions
    
    func fetchGameDescriptions(ids: [Int]) {
        
//        let newIds = ids.filter { !loadedIds.contains($0) }
//        guard !newIds.isEmpty else { return }
        

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
//                        strongSelf.loadedIds.insert(id)
                        
                    case .failure(let error):
                        strongSelf.errorMessage = error.localizedDescription
                    }
                }
            }
        }

        group.notify(queue: .main) {
            [weak self] in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
        }
    }
    
    func fetchCartItems(ids: [Int]) {
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
                        strongSelf.cartItems[id] = description
                    case .failure(let error):
                        strongSelf.errorMessage = error.localizedDescription
                    }
                }
            }
        }

        group.notify(queue: .main) {
            [weak self] in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
        }
    }
    
    func addItemToCart(_ gameId: Int) {
            // Assuming you have a method or a way to get GameDescription by gameId
            if let gameDescription = fetchGameDescriptionById(gameId) {
                cartItems[gameId] = gameDescription
            }
    }
    
    private func fetchGameDescriptionById(_ gameId: Int) -> GameDescription? {
            // Assuming gameDescriptions dictionary contains the required game descriptions
            return gameDescriptions[gameId]
    }
    
    func removeItemFromCart(_ gameId: Int) {
            cartItems.removeValue(forKey: gameId)
    }

}


