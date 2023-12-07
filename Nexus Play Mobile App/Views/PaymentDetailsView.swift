//
//  PaymentDetailsView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 11/30/23.
//

import SwiftUI

import UIKit

struct PaymentDetailsView: View {
    @State private var paymentDetails = PaymentDetails()
    
    @State private var isChecked: Bool = false
    
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
            
//          Content
            ScrollView() {
                Text("Payment Information")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)

                Text("Please do not enter real card information. This is a demo.")
                    .foregroundColor(.red)
                    .padding()

                VStack(alignment: .leading) {
                    
                    Text("Card Details")
                        .padding(.horizontal, 30)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                    
                    TextField("", text: $paymentDetails.cardNumber, prompt: Text("Card Number").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)

                    TextField("", text: $paymentDetails.expirationDate, prompt: Text("Expiration Date (MM/YY)").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)

                    TextField("", text: $paymentDetails.cvv, prompt: Text("CVV").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                    
                    TextField("", text: $paymentDetails.cardHolder, prompt: Text("Cardholder Name").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                }
                .padding(.bottom, 20)
                
                VStack(alignment: .leading) {
                    Text("Billing Address")
                        .padding(.horizontal, 30)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                    
                    TextField("", text: $paymentDetails.street, prompt: Text("Street Address").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                    
                    TextField("", text: $paymentDetails.apartment, prompt: Text("Apartment/Flat No.").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                    
                    TextField("", text: $paymentDetails.city, prompt: Text("City").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                    
                    TextField("", text: $paymentDetails.state, prompt: Text("State").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                    
                    TextField("", text: $paymentDetails.country, prompt: Text("Country").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                    
                    TextField("", text: $paymentDetails.zipCode, prompt: Text("Zip Code").foregroundStyle(.gray))
                        .foregroundStyle(Color.white)
                        .textFieldStyle(MyTextFieldStyle())
                        .padding(.horizontal, 30)
                        .padding(.vertical, 5)
                    
                }
                .padding(.bottom)
                
                HStack {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                        .resizable()
                        .onTapGesture {
                            self.isChecked.toggle()
                        }
                        .foregroundStyle(Color.pink)
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 15)
                        
                    Text("Save Card and Billing Details for future purchases")
                        .foregroundStyle(Color.white)
                }
                .padding(.horizontal, 5)

                NavigationLink(destination: PaymentSuccessView()) {
                    Text("Purchase")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
                .padding(.vertical)

                Spacer()
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

struct PaymentDetails {
    var cardNumber: String = ""
    var expirationDate: String = ""
    var cvv: String = ""
    var cardHolder: String = ""
    var street: String = ""
    var apartment: String = ""
    var city: String = ""
    var state: String = ""
    var country: String = ""
    var zipCode: String = ""
}

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(.black)
                    .opacity(0.7)
                    .cornerRadius(10)
                    
            )
            .cornerRadius(10)
    }
}

struct PaymentDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentDetailsView()
    }
}

