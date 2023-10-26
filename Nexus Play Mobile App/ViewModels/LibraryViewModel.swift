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
    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetchGameTitles()
    }

    func fetchGameTitles() {
        GameTitleAPI.fetchGameTitles { [weak self] titles in
            let sortedTitles = titles.sorted { $0.name < $1.name }
            let titlesFrom50thOnwards = Array(sortedTitles.dropFirst(1699))
            self?.gameTitles = titlesFrom50thOnwards
        }
    }
}


