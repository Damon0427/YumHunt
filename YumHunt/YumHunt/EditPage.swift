//
//  SwiftUIView.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/28/24.
//

import SwiftUI

struct EditPage: View {
    
    let username: String
    let currentPassword: String
    @State private var newPassword: String = ""
    @StateObject var coreDataVM = coreDataviewModel()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Current Username")) {
                    Text("\(username)")
                }

                Section(header: Text("Current Password:")) {
                    Text("\(currentPassword)")
                   
                }
                Section(header: Text("New Password")) {

                TextField("Enter your new password", text: $newPassword)
                }
                

                Section {
                    
                    Button("Update information") {
                        coreDataVM.updatePassword(currentUser: username, newPassword: newPassword)
                        
                        }
                    }
                }
            .navigationBarTitle("Edit information")
        }
    }
}



#Preview {
    EditPage(username: "", currentPassword:"")
}
