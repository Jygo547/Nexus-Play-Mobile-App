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
    
    let viewModel = GameDescriptionViewModel()
    
    @StateObject var tabSelectionManager = TabSelectionManager()
    
    init() {
            UITabBar.appearance().barTintColor = .black 
        }
    
    
    var body: some View {
        TabView(selection: $tabSelectionManager.selectedTab) {
            
            NavigationView {
                StoreView()
            }
                .tabItem {
                    Label("Store", systemImage: "tag")
                }
                .tag(0)
            
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "book")
                }
                .tag(1)
            
            NavigationStack {
                CartView(viewModel: viewModel)
            }
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(3)
        }
        .environmentObject(tabSelectionManager)

    }
}

#Preview {
    MainView()
}

