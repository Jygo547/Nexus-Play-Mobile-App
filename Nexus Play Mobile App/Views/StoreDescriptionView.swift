//
//  StoreDescription.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/16/23.
//

import SwiftUI

struct StoreDescriptionView: View {
    @ObservedObject var viewModel: GameDescriptionViewModel
    let gameId: Int
    @State private var price: Double = Double.random(in: 10...100)
    
    init(gameId: Int) {
        self.gameId = gameId
        viewModel = GameDescriptionViewModel()
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor.black.withAlphaComponent(0.85)

        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
        UINavigationBar.appearance().standardAppearance = standardAppearance
    }
    
    private func addToCart() {
        var cartIds = UserDefaults.standard.array(forKey: "cartIds") as? [Int] ?? []
        if !cartIds.contains(gameId) {
            cartIds.append(gameId)
            UserDefaults.standard.set(cartIds, forKey: "cartIds")
        }
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
                        
                        HStack(alignment: .center, spacing: 2) {
                            Text("Rating:")
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .padding(.leading, 5)
                            Text(String(format: "%.2f", gameDescription.rating))
                        }
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top, 5)
                        
                        Text("Release Date: \(gameDescription.released)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top, 5)
                        
                        HStack {
                            Text(String(format: "$%.2f", price))
                                .padding()
                                .fontWeight(.bold)
                                .background(Color.green)
                                .cornerRadius(5)
                            
                            Spacer()
                            
                            NavigationLink(destination: CartView(viewModel: viewModel)) {
                                        Image(systemName: "cart.fill.badge.plus")
                                        Text("Add to cart")
                                            .padding(.horizontal, 2)
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.pink)
                                .cornerRadius(5)
                                .onTapGesture {
                                    addToCart()
                                }
                                
                        }
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
            .onAppear {
                viewModel.fetchGameDescriptions(ids: [gameId])
            }
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

struct StoreDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDescriptionView(gameId: 123)
    }
}

