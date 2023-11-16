//
//  StoreView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/9/23.
//

import SwiftUI

struct StoreView: View {
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
                        
//                        Main Banner
                        if viewModel.gameTitles.count > 1 {
                            let mainBannerGame = viewModel.gameTitles[1] // Access the second element
                            NavigationLink(destination: GameDescriptionView(gameId: mainBannerGame.id)) {
                                MainBanner(game: mainBannerGame)
                            }
                        }
                        
                        // Featured Section
                        Text("Featured")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top) {

                                ForEach(Array(viewModel.gameTitles.dropFirst(15).prefix(5)), id: \.self) { game in
                                    NavigationLink(destination: StoreDescriptionView(gameId: game.id)) {
                                        StoreRow(game: game)
                                    }
                                }
                            }
                        }
                        .onAppear {
                            viewModel.fetchGameTitles()
                        }
                        
                        // Recommended Section
                        Text("Recommended")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top) {

                                ForEach(Array(viewModel.gameTitles.dropFirst(2)), id: \.self) { game in
                                    NavigationLink(destination: StoreDescriptionView(gameId: game.id)) {
                                        StoreRow(game: game)
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

//New struct for Main Banner
struct MainBanner: View {
    let game: GameTitle
    
    var body: some View {
        VStack(alignment: .center) {
            if let url = URL(string: game.backgroundImage) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350)
                        .cornerRadius(5)
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 350)
                }
            }
            Text(game.name)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.vertical, 5)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .frame(maxWidth: 400, alignment: .center)
        }
        .padding()
    }
}

//New Struct for Store Games

struct StoreRow: View {
    let game: GameTitle
    
    @State private var price: Double = Double.random(in: 10...100)
    
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
                
            Text(String(format: "$%.2f", price))
                .padding(.vertical, 7)
                .padding(.horizontal, 10)
                .fontWeight(.bold)
                .background(Color.green)
                .cornerRadius(5)
        }
        .padding()
    }
}


// Preview
struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}
