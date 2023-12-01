//
//  MainTabView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/3/23.
//

import SwiftUI


struct MainView: View {
    
    let viewModel = GameDescriptionViewModel()  
    
    init() {
            UITabBar.appearance().barTintColor = .black 
        }
    
    
    var body: some View {
        TabView {
            
            NavigationView {
                StoreView()
            }
                .tabItem {
                    Label("Store", systemImage: "cart")
                }
            
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "book")
                }
            
            NavigationStack {
                CartView(viewModel: viewModel)
            }
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
            
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    MainView()
}

