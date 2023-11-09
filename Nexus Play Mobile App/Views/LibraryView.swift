//
//  ContentView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 10/26/23.
//

import SwiftUI

struct LibraryView: View {
    @ObservedObject var viewModel = LibraryViewModel()

   init() {
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.black.withAlphaComponent(0.85)

        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
        UINavigationBar.appearance().standardAppearance = standardAppearance
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Image("BackgroundImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                
                // Content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        // Recently Played Section
                        Text("Recently Played")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top) {

                                ForEach(Array(viewModel.gameTitles.prefix(5)), id: \.self) { game in
                                    NavigationLink(destination: GameDescriptionView(gameId: game.id)) {
                                        GameRow(game: game)
                                    }
                                }
                            }
                        }
                        .onAppear {
                            viewModel.fetchGameTitles()
                        }
                        
                        // All Games Section
                        Text("All Games")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top) {

                                ForEach(Array(viewModel.gameTitles.dropFirst(5).prefix(10)), id: \.self) { game in
                                    NavigationLink(destination: GameDescriptionView(gameId: game.id)) {
                                        GameRow(game: game)
                                    }
                                }
                            }
                        }
                        .onAppear {
                            viewModel.fetchGameTitles()
                        }
                    }
                }
                .background(Color.clear)
            }
            .foregroundColor(.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                }
            }
        }
    }
}

// New struct for the game row view
struct GameRow: View {
    let game: GameTitle
    
    var body: some View {
        VStack(alignment: .leading) {
            if let url = URL(string: game.backgroundImage) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 200)
                        .cornerRadius(5)
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 300, height: 200)
                }
            }
            Text(game.name)
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 5)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .frame(width: 300, alignment: .leading)
                
            Text("Release Date: \(game.released)")
                .frame(width: 300, alignment: .leading)
        }
        .padding()
    }
}

// Preview
struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}

