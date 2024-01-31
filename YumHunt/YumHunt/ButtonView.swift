//
//  ButtonView.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/24/24.
//

import SwiftUI

struct ButtonView: View {
    
    let buttonIcon: String
    let text: String
    let behavior: Behavior
    let userId: String
    let coreDataVM =  coreDataviewModel ()
    @Binding var isLogIn: Bool

    var body: some View {
        Button(action: {
            
        }, label: {
            HStack{
                Image(systemName: "\(buttonIcon)")
                    .renderingMode(.original)
                    .imageScale(.large)
                Text("\(text)")
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


