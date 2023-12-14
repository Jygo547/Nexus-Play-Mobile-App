//
//  MainTabView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/3/23.
//

import SwiftUI

import UIKit

class TabSelectionManager: ObservableObject {
    @Published var selectedTab: Int = 0
}


struct MainView: View {
    
    @StateObject var libraryViewModel = LibraryViewModel()
    @StateObject var gameDescriptionViewModel = GameDescriptionViewModel()
    
    @StateObject var tabSelector = GlobalTabSelectionManager()
    
    init() {
            UITabBar.appearance().barTintColor = .black 
        }
    
    
    var body: some View {
        TabView(selection: Binding(
            get: { tabSelector.selectedTab },
            set: { tabSelector.selectedTab = $0 }
        )) {
            
            NavigationView {
                StoreView()
            }
                .tabItem {
                    Label("Store", systemImage: "tag")
                }
                .tag(GlobalTabSelectionManager.TabIndices.store)
            
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "book")
                }
                .tag(GlobalTabSelectionManager.TabIndices.library)
            
            NavigationStack {
                CartView(viewModel: gameDescriptionViewModel)
            }
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .tag(GlobalTabSelectionManager.TabIndices.cart)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(GlobalTabSelectionManager.TabIndices.profile)
        }
        .environmentObject(tabSelector)

    }
}

#Preview {
    MainView()
}

