//
//  PaymentSuccessView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 12/6/23.
//

import SwiftUI

import UIKit

struct PaymentSuccessView: View {
    
    @EnvironmentObject var tabSelector: GlobalTabSelectionManager
    
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
        ZStack{
            
            // Background
            Image("BackgroundImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                Image("PurchaseIllustration")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding(.horizontal)
                
                Text("Purchase Successful!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.horizontal)

                Text("Your game is now queued for download on your PC. Check the 'Downloads' section of our PC launcher for progress updates.")
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    
                
                Text("Once the download is complete, you'll receive a notification on this device, and your game will be ready to play. Feel free to explore more games and features on your mobile in the meantime. Happy gaming!")
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    .padding(.bottom, 10)

                // Button to go back to the root view
                
                Button(action: {
                    // Trigger tab change after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        tabSelector.selectedTab = .store
                    }
                }) {
                    Text("Back to Home")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
            }

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

struct PaymentSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSuccessView()
    }
}



