//
//  MainTabView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/3/23.
//

import SwiftUI


struct MainView: View {
    
    init() {
            UITabBar.appearance().barTintColor = .black 
        }
    
    
    var body: some View {
        TabView {
            
            StoreView()
                .tabItem {
                    Label("Store", systemImage: "cart")
                }
            
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "book")
                }
            
            Text("Community")
                .tabItem {
                    Label("Community", systemImage: "person.3")
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

