//
//  GlobalTabSelectionManager.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 12/14/23.
//

import SwiftUI

final class GlobalTabSelectionManager: ObservableObject {
    enum TabIndices {
        case store, library, cart, profile
    }

    @Published var selectedTab: TabIndices = .store
}
