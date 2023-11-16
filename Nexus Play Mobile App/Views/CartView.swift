//
//  CartView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/16/23.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: GameDescriptionViewModel
    @State private var price: Double = Double.random(in: 10...100)

    init(gameId: Int) {
        viewModel = GameDescriptionViewModel()
        viewModel.fetchGameDescription(id: gameId)
        
        // Navigation bar appearance settings
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
                    if let gameDescription = viewModel.gameDescription {
                        VStack(alignment: .leading) {
                            
                            Text("Cart")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            // Game Image
                            HStack {
                                if let url = URL(string: gameDescription.backgroundImage) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100)
                                            .cornerRadius(5)
                                            .clipped()
                                    } placeholder: {
                                        Rectangle().foregroundColor(.gray)
                                    }
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.vertical)
                                }
                                
                                // Game Name
                                VStack(alignment: .leading) {
                                    Text(gameDescription.name)
                                        
                                        .fontWeight(.bold)
                                        .padding(.top, 5)
                                    
                                    
                                    // Price
                                    Text(String(format: "$%.2f", price))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.green)
                                }
                                
                                Spacer()
                                
                                Text("Remove")
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.red)
                                    .underline()
                                
                            }
                            .overlay(
                                Rectangle()
                                    .frame(height: 1)
                                    .offset(y: 5)
                                    .foregroundColor(.gray),
                                alignment: .bottom
                            )
                            HStack {
                                NavigationLink(destination: StoreView()) {
                                    Image(systemName: "arrowshape.turn.up.backward.fill")
                                    Text("Add more games")
                                }
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(5)
                                
                                Spacer()
                                
                                NavigationLink(destination: StoreView()) {
                                    Image(systemName: "creditcard.fill")
                                    Text("Purchase")
                                }
                                .padding()
                                .background(Color.green)
                                .cornerRadius(5)
                            }
                        }
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    } else if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Could not load game details.")
                    }
                }
            }
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

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(gameId: 123)
    }
}
