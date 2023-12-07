//
//  ProfileView.swift
//  Nexus Play Mobile App
//
//  Created by ATLAS Checkout 6 Guest on 12/7/23.
//

import SwiftUI

struct ProfileView: View {
    // Sample data for demonstration
    let fullName = "John Doe"
    let nationality = "American"
    let mobileNumber = "+1234567890"
    let username = "john_doe"
    let email = "johndoe@example.com"
    let securityQuestion = "Your first pet's name?"

    // Sample friends list
    let friends = [("person1", "Alice", "10 mins ago"), ("person2", "Bob", "1 hour ago"), ("person3", "Charlie", "Yesterday")]
    
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
                //            Background
                Image("BackgroundImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .edgesIgnoringSafeArea(.all)
                
                //            Content
                ScrollView {
                    VStack(alignment: .center) {
                        
                        VStack(spacing: 20) {
                            Image("myProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                                .cornerRadius(20)
                            
                            Text("@\(username)")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                        }
                        // Personal Information Section
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Personal Information")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 10)
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                PersonalInfoRow(label: "Full Name", value: fullName)
                                PersonalInfoRow(label: "Nationality", value: nationality)
                                PersonalInfoRow(label: "Mobile Number", value: mobileNumber)
                                PersonalInfoRow(label: "Username", value: username)
                                
                            }
                            PersonalInfoRow(label: "Email", value: email)
                            PersonalInfoRow(label: "Security Question", value: securityQuestion)
                        }
                        .padding()
                        
                        // Friends List Section
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Friends List")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 10)
                            
                            ForEach(friends, id: \.0) { friend in
                                HStack {
                                    Image("\(friend.0)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 30, height: 30)
                                        .padding(.leading)
                                    Text(friend.1)
                                    Spacer(minLength: 20)
                                    Text("Last Active: \(friend.2)")
                                        .foregroundColor(.gray)
                                        .font(.footnote)
                                        .padding(.trailing)
                                }
                                .frame(height: 60)
                                .cornerRadius(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .foregroundColor(.black)
                                        .opacity(0.6)
                                        .cornerRadius(10)
                                )
                                
                            }
                        }
                        .padding()
                        
                        // Logout Button
                        Button(action: {}) {
                            Text("Logout")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        .disabled(true)
                        .padding()
                    }
                    .padding(.horizontal)
                }
            }
            .foregroundStyle(Color.white)
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

    struct PersonalInfoRow: View {
        var label: String
        var value: String

        var body: some View {
            VStack(alignment: .leading) {
                Text(label)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                
                TextField("", text: .constant(value))
                    .font(.body)
                    .disabled(true)
                    .textFieldStyle(ProfileField())
            }
        }
    }

    struct ProfileField: TextFieldStyle {
        func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .foregroundColor(.black)
                        .opacity(0.3)
                        .cornerRadius(10)
                        
                )
                .cornerRadius(10)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
            ProfileView()
    }
}

