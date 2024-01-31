//
//  SearchPage.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/17/23.
//

import SwiftUI
import CoreLocation

enum SortOrder {
    case ratingAscending
    case ratingDescending
    case `default`
}   

struct SearchPage: View {
    
    @Binding var searchText: String
    @Binding  var selectedTab: Int
    @StateObject private var locationManager = LocationManager()
    @State var sortOrder: SortOrder = .default
    @State var showDeliveryOnly = false
    @State var nearBy = false

    @EnvironmentObject var vm: ApiData
    
    private var nearbyBusinesses: [business] {
        let distanceNearBy = 2000.0
        guard let userLocation = locationManager.location else {
                return []
            }
        return vm.searchResults.filter { business in
            let businessesLocation = CLLocation(latitude: business.coordinates.latitude, longitude: business.coordinates.longitude)
            return userLocation.distance(from: businessesLocation) <= distanceNearBy
            
        }.sorted { business1, business2 in
            let business1Location = CLLocation(latitude: business1.coordinates.latitude, longitude: business1.coordinates.longitude)
            let business2Location = CLLocation(latitude: business2.coordinates.latitude, longitude: business2.coordinates.longitude)
            let distance1 = userLocation.distance(from: business1Location) / 1609.34
            let distance2 = userLocation.distance(from: business2Location) / 1609.34
            return distance1 < distance2
        }
    }
    private var ratingSort : [business] {
        if sortOrder == .ratingDescending{
            return vm.searchResults.sorted(by: { $0.rating > $1.rating})
        }else
        {
            return vm.searchResults.sorted(by: { $0.rating < $1.rating})
        }
    }
    private var ratingAndNearbySort : [business] {
        if sortOrder == .ratingDescending{
            return nearbyBusinesses.sorted(by: { $0.rating > $1.rating})
        }else
        {
            return nearbyBusinesses.sorted(by: { $0.rating < $1.rating})
        }
    }
    
    //use to handle the different sorting situation, when filter icon got tab
    private var displayedBusinesses: [business] {
        if nearBy && sortOrder != .default {
            return ratingAndNearbySort
        } else if nearBy {
               return nearbyBusinesses
        } else if sortOrder != .default {
               return ratingSort
        }
         return vm.searchResults
       }

    //use to display the result of search
    private let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    var body: some View {
        
        NavigationView{
            VStack {
                Text("Search")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                ScrollView{
                    SearchBar(searchText: $searchText, selectedTab: $selectedTab)
                        .autocorrectionDisabled()
                        .keyboardType(.webSearch)
                        .onSubmit {
                            if let location = locationManager.location {
                                nearBy = false
                                sortOrder = .default
                                SearchFunction(with: searchText, location: location)
                                
                            }
                        }
                        .padding()
                    FilterView(sortOrder: $sortOrder, showDeliveryOnly: $showDeliveryOnly, nearBy: $nearBy)
                    
                    
                    //                Text("Restreant near you : ")
                    //                    .font(.system(size: 25))
                    //                    .font(.subheadline)
                    //                    .padding(.leading, 20)
                    //                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    
                    if !self.displayedBusinesses.isEmpty, let location = locationManager.location{
                        ForEach (displayedBusinesses) { card in
                            NavigationLink {
                                detailPage(business: card)
                            } label: {
                                CardRow(business: card,userLocation: location)
                            }

                            
                        }
                        
                    }
                    
                    
                    
                }
            }
    }
//            .background(LinearGradient(colors: [Color.green.opacity(0.8), Color.white], startPoint: .topLeading, endPoint: .bottomTrailing))
}


    private func SearchFunction(with searchText: String,location: CLLocation) {
        print("Searching with : \(searchText)  from location: \(location.coordinate.latitude)  and \(location.coordinate.longitude)")
        
        vm.loadData(dataType: .search,searchText: searchText, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

    }
   
        
}


//#Preview {
//    SearchPage(searchText: .constant(" "),selectedTab: .constant(1), busneseArray: .constant([]))
//}
//
