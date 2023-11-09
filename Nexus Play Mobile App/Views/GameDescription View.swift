//
//  GameDescription View.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/9/23.
//

import SwiftUI

struct GameDescriptionView: View {
    @ObservedObject var viewModel: GameDescriptionViewModel
    
    init(gameId: Int) {
        viewModel = GameDescriptionViewModel()
        viewModel.fetchGameDescription(id: gameId)
        
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
                if let gameDescription = viewModel.gameDescription {
                    VStack(alignment: .leading) {
                        
                        if let url = URL(string: gameDescription.backgroundImage) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                Rectangle().foregroundColor(.gray)
                            }
                            .aspectRatio(contentMode: .fit)
                            .padding()
                        }
                        
                        Text(gameDescription.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top, 5)
                        
                        HStack(alignment: .center, spacing: 2) {
                            Text("Rating:")
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .padding(.leading, 5)
                            Text(String(format: "%.2f", gameDescription.rating))
                        }
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top, 2)
                        
                        Text("Release Date: \(gameDescription.released)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top, 2)
                        
                        Text("Description:")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                            .padding(.top, 2)
                        
                        Text(gameDescription.description)
                            .padding(.horizontal)
                            .padding(.top, 2)
                    }
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
