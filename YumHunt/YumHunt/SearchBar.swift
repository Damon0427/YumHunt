//
//  SearchBar.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/21/23.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var selectedTab: Int
    var body: some View {
        HStack {
            
            TextField("e.g Restareunt ", text: $searchText)
                .padding()
                .padding(.leading, 35)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                        .padding()
                    )
        }

        
    }
    
}
#Preview {
    SearchBar(searchText: .constant(""), selectedTab: .constant(1))
}
