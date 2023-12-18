//
//  GameDescription View.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/9/23.
//

import SwiftUI

import UIKit

struct GameDescriptionView: View {
    @ObservedObject var viewModel = GameDescriptionViewModel.shared
    let gameId: Int
    @State private var price: Double = Double.random(in: 10...100)
    
    init(gameId: Int) {
        self.gameId = gameId
        viewModel = viewModel
        viewModel.fetchGameDescriptions(ids: [gameId])
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.black.withAlphaComponent(0.85)

        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
        UINavigationBar.appearance().standardAppearance = standardAppearance
    }
    
    var body: some View {
        
        ZStack{
            
    //      Background
            Image("BackgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            
    //      Content
            ScrollView {
                if let gameDescription = viewModel.gameDescriptions[gameId] {
                    VStack(alignment: .leading) {
                        
                        if let url = URL(string: gameDescription.backgroundImage) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                Rectangle().foregroundColor(.gray)
                            }
                            .aspectRatio(contentMode: .fit)
                            .padding(.vertical)
                        }
                        
                        Text(gameDescription.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 5)
                        
                        Text("Release Date: \(gameDescription.released)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top, 5)
                        
                        Text("Description:")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top, 20)
                        
                        Text(gameDescription.description
                            .replacingOccurrences(of: "<p>", with: "")
                            .replacingOccurrences(of: "</p>", with: "")
                            .replacingOccurrences(of: "<br />", with: "\n"))
                            .padding(.top, 2)
                    }
                    .padding(.horizontal)
                } else if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Could not load game details.")
                }
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

struct GameDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        GameDescriptionView(gameId: 123)
    }
}
