//
//  CardView.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/22/23.
//

import SwiftUI

struct CardView: View {
    let name: String
    let rating: Double
    let imageURL: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        
        
                VStack {
                    AsyncImage(url: URL(string: imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 150, height: 120)
                        case .success(let image):
                            image.resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(width: 150, height: 120)
                                 .cornerRadius(3.0)
                                 .clipped()
                        case .failure:
                            Image(systemName: "photo")
                                .frame(width: 150, height: 120)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .overlay(
                        RatingView(rating: rating)
                            .background(Color.white.opacity(0.5)),
                        alignment: .bottomLeading
                            
                    )
        
                    Text(name)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .truncationMode(.tail)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .bottom], 20.0)
                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                }
                .frame(width: 150, height: 150)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0.5)))
            }
    }


#Preview {
    CardView(name: "Mcdonal", rating: 5.0, imageURL: "")
}
