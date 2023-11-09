//
//  GameDescriptionViewModel.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/9/23.
//

import Combine

class GameDescriptionViewModel: ObservableObject {
    @Published var gameDescription: GameDescription?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchGameDescription(id: Int) {
        isLoading = true
        GameTitleAPI.shared.fetchGameDescription(id: id) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let description):
                self?.gameDescription = description
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}

