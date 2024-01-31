//
//  SignUpPage.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/15/24.
//

import SwiftUI

struct SignUpPage: View {
    @State private var userId: String = ""

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword = ""
    @StateObject var coreDataVM = coreDataviewModel()
    @Binding var showSheet: Bool
    var body: some View {
        VStack{
            Text("Register an Account")
                .font(.title)
                .frame(height: 100)
                
                .foregroundStyle(Color.white)
            Divider()
                .padding(.top,20)
            VStack (spacing: 15){
                TextField("User ID", text: $userId)
                    .padding()
                    
                    .foregroundStyle(Color.black)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)


                
                TextField("Email",text: $email )
                    .padding()
                    
                    .foregroundStyle(Color.black)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                TextField("Password", text: $password)
                    .padding()
                    
                    .foregroundStyle(Color.black)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                TextField("Confirm Password", text: $confirmPassword)
                    .padding()
                    
                    .foregroundStyle(Color.black)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)

                Button {
                    //if statement to check if the username is valid
                    if coreDataVM.isPasswordValid(password: password){
                        
                        coreDataVM.addUser(userName: userId, passWord: password, email: email)
                        print("Register success")
                    }
                    showSheet.toggle()
                } label: {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 25)

            Spacer()
        }
        
       
        
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom))
    }
        
        
}

#Preview {
    SignUpPage(showSheet: .constant(false))
}
