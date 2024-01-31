//
//  WelcomePage.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/29/23.
//

import SwiftUI

struct WelcomePage: View {
//    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject var vm: ApiData
    @Binding var isLoaded: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing:20){
                    Text("Welcome to the YumHunt App")
                        .bold()
                    
                        .font(.title)
                    
                    Text("Please share your current location to get the nearby restrant!")
                    
                    
                    Button {
                        isLoaded.toggle()
                    } label: {
                        Text("Start")
                            .bold()
                            .padding()
                            .foregroundStyle(Color.red)
                        
                            .cornerRadius(4)
                    }

                        
                    
                    
                    
                }
            }
            
        }
//        .onChange(of: locationManager.location) {
//            
//            if let location = locationManager.location, !vm.isDataLoaded {
//                vm.loadData(searchText: "Fastfood", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//                
//            }
//
//        }

        .multilineTextAlignment(.center)
        }
    
}

#Preview {
    WelcomePage( isLoaded: .constant(false))
}
