//
//  SwiftUIView.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/28/24.
//

import SwiftUI

struct SwiftUIView: View {
    
    @Binding var username: String
    @Binding var currentPassword: String
    @State private var newPassword: String = ""
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
                                
                            }
                        }
                    }
                    .navigationBarTitle("Edit information")
                }
            }
    }



#Preview {
    SwiftUIView(username: .constant(""), currentPassword: .constant(""))
}
