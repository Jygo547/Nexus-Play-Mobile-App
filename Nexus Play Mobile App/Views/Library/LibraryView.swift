//
//  ContentView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 10/26/23.
//

import SwiftUI

struct LibraryView: View {
    @StateObject private var viewModel = LibraryViewModel()

    var body: some View {
        TabView {
            NavigationView {
                List(viewModel.gameTitles) { game in
                    Text(game.name)
                }
                .navigationBarTitle("Library", displayMode: .large)
                .onAppear {
                    viewModel.fetchGameTitles()
                }
            }
            .tabItem {
                Image(systemName: "gamecontroller.fill")
                Text("Library")
            }
            
            Text("Placeholder for Store")
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Store")
                }
            
            Text("Placeholder for Community")
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Community")
                }
            
            Text("Placeholder for Profile")
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    LibraryView()
}
