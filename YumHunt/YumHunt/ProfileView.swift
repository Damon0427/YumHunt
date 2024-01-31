//
//  ProfileView.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/21/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var userId: String
    @Binding var isLogin: Bool
    @StateObject var coreDataVM = coreDataviewModel()

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Rectangle()
                        .frame(width: 150, height: 1)
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .foregroundColor(.black)
                    Rectangle()
                        .frame(width: 150, height: 1)
                }
                
                Text("\(userId)")
                    .font(.headline)
                    .padding()
                NavigationLink {
                    EditPage(username: userId, currentPassword: coreDataVM.returnPassword(userName: userId))
                } label: {
                    HStack{
                        Image(systemName: "pencil")
                            .renderingMode(.original)
                            .imageScale(.large)
                        Text("Edit Profile")
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        
                    }
                    .padding()

                    .frame(maxWidth: .infinity)
                    
                    .background(.thinMaterial)
                    .cornerRadius(10)
                }
               
                    
            
            .padding(.horizontal,20)
                ButtonView(buttonIcon: "pencil", text: "Edit Profile", behavior: .default, userId:userId, isLogIn: $isLogin)

                NavigationLink {
                    CollectionPage()
                } label: {
                    HStack{
                        Image(systemName: "heart.fill")
                            .renderingMode(.original)
                            .imageScale(.large)
                        Text("Collection")
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        
                    }
                    .padding()

                    .frame(maxWidth: .infinity)
                    
                    .background(.thinMaterial)
                    .cornerRadius(10)
                }
                .padding(.horizontal,20)

                Button(action: {
                    coreDataviewModel().logOutUser(username: userId)
                    isLogin.toggle()
                }, label: {
                    HStack{
                        Image(systemName: "figure.run")
                            .renderingMode(.original)
                            .imageScale(.large)
                        Text("  Log Out")
                            .fontWeight(.medium)
                            .foregroundStyle(Color.black)
                        
                    }
                    .padding()

                    .frame(maxWidth: .infinity)
                    
                    .background(.thinMaterial)
                    .cornerRadius(10)
                        
                })
                .padding(.horizontal,20)
                
        
            }
            
           
            }
    }
}

#Preview {
    ProfileView(userId: .constant("Damon"), isLogin: .constant(false) )
}
