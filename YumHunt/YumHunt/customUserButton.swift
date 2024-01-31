//
//  customUserButton.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/20/24.
//

import SwiftUI

struct customUserButton: View {
    @Binding var showsRedDot: Bool
    var body: some View {
        Image(systemName: "person")
            .frame(width: 40,height: 40)
            .overlay(
                showsRedDot ? Circle().fill(Color.red.opacity(0.6)).frame(width: 11, height: 11).offset(x: -10, y: -10) : nil
            )
        Text("User")
    }
}

#Preview {
    customUserButton(showsRedDot: .constant(false))
}
