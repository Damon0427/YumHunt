//
//  RatingView.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/25/23.
//

import SwiftUI

struct RatingView: View {
    let rating: Double

    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundStyle(Color.yellow)
            
            Text("\(String(format: "%.1f", rating))")
                .foregroundStyle(Color.black)
                .font(.headline)
                .fontWeight(.semibold)
        }
        .frame(width: 60)
        
    }
}

#Preview {
    RatingView(rating: 4.5)
}
