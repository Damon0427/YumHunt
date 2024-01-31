//
//  FilterView.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/14/24.
//

import SwiftUI



struct FilterView: View {
    @Binding var sortOrder: SortOrder
    @Binding var showDeliveryOnly: Bool
    @Binding var nearBy : Bool
    var body: some View {
        HStack {
        
            
            Button(action: {
                withAnimation (.easeInOut(duration: 0.4)){
                
                    switch sortOrder {
                    case .ratingAscending:
                        sortOrder = .ratingDescending
                    case .ratingDescending, .default:
                        sortOrder = .ratingAscending
                    }
                    print("Sort order changed to \(sortOrder)")
                }
            }) {
                switch sortOrder {
                case .ratingAscending:
                    Image(systemName: "arrow.down")
                case .ratingDescending, .default:
                    Image(systemName: "arrow.up")
                            }
                          Text("Rating")
                
            }
            .foregroundStyle(Color.black.opacity(0.7))
            .fontWeight(.semibold)
            .frame(height: 30)
            .shadow(radius: 1)
            .padding(.horizontal)
            Divider()
            Button {
                
                    nearBy.toggle()
                    print("nearBy value :\(nearBy)")
                
            } label: {
                Image(systemName: nearBy ? "paperplane.circle.fill" : "paperplane.circle")

                Text("NearBy")
            }
            .foregroundStyle(Color.black.opacity(0.7))
            .fontWeight(.semibold)
            .frame(height: 30)
            .shadow(radius: 1)
            .padding(.horizontal)
        Spacer()
        }

        

            
            Divider()
            
        
        }
    
        
    }

#Preview {
    FilterView(sortOrder: .constant(.ratingDescending), showDeliveryOnly: .constant(true), nearBy: .constant(false))
}
