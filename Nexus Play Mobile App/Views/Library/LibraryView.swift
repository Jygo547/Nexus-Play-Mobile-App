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
                        Text("Featured Games")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Array(viewModel.gameTitles.prefix(5)), id: \.self) { game in
                                    VStack(alignment: .leading) {
                                        if let url = URL(string: game.backgroundImage) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 300, height: 200)
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
                                            .padding(.vertical, 5)
                                        Text("Release Date: \(game.released)")
                                    }
                                    .padding()
                                }
                            }
                        }
                        .onAppear {
                            viewModel.fetchGameTitles()
                        }
                        
                        Text("Recommended")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Array(viewModel.gameTitles.dropFirst(5).prefix(10)), id: \.self) { game in
                                    VStack(alignment: .leading) {
                                        if let url = URL(string: game.backgroundImage) {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 300, height: 200)
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
                                            .padding(.vertical, 5)
                                        Text("Release Date: \(game.released)")
                                    }
                                    .padding()
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

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
