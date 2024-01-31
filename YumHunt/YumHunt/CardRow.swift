//
//  CardRow.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/19/24.
//

import SwiftUI
import CoreLocation

struct CardRow: View {
    let business: business
    let userLocation: CLLocation
    @State var isPressed: Bool = false
    
    var distanceInmile: Double {
        let businessLocation = CLLocation(latitude: self.business.coordinates.latitude, longitude: self.business.coordinates.longitude)
        let distanceInmeter = userLocation.distance(from: businessLocation)
        return distanceInmeter / 1609.34
    }
    
    var body: some View {
        
        HStack{
            AsyncImage(url: URL(string: business.imageURL)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:140, height: 140)
                        .clipped()
                    
                    
                }else if phase.image == nil {
                    ProgressView()
                }
                else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width:200, height: 200)
                }
            }
            .cornerRadius(10)
            Spacer()
            VStack (alignment: .trailing,spacing: 8) {
                Text("\(business.name)")
                    .font(.title2)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text("\(String(format: "%.2f", distanceInmile)) miles")
                    .font(.caption)
                    .fontWeight(.semibold)
                
                RatingView(rating: business.rating)
                Button(action: {
                    
                    self.isPressed.toggle()
                }) {
                    Image(systemName: "plus.circle")
                        .frame(width: 70,height: 70)
                        .foregroundColor(.black)
                        .animation(.easeIn(duration: 0.2), value: isPressed)
                }
            }
            
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
    }

