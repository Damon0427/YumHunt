//
//  UserPage.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/17/23.
//

import SwiftUI

struct UserPage: View {
    @EnvironmentObject var vm: ApiData
    @State var islogIn: Bool = false
    @State var userID: String = ""

    var body: some View {
        Group{
            if islogIn{
                ProfileView(userId: $userID, isLogin: $islogIn)
            }
            else{
                loginPage(userId: $userID, isLogIn: $islogIn)
                    .transition(.opacity)
            }
        }
    }
    
        
}

#Preview {
    UserPage()
}
