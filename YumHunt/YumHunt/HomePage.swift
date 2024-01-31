//
//  HomePage.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/17/23.
//

import SwiftUI


struct HomePage: View {
    
    init() {
        //changing the background of the tabBar by using uikit        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        
    }
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var locationManager = LocationManager()
    @EnvironmentObject var vm: ApiData
    @State private var selectedTab = 0
    @State private var searchText = ""
    @State var isLoaded: Bool = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                TabView(selection: $selectedTab){
                    
                    MainPage(businesses: $vm.businesses, selectedTab: $selectedTab, searchText: $searchText)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                            
                            
                        }
                    
                        .tag(0)
                        .transition(.slide)
                        .animation(.easeInOut, value: selectedTab)
                    SearchPage(searchText: $searchText,selectedTab: $selectedTab)
                        .tabItem {
                            Image(systemName:"magnifyingglass")
                            Text("Search")
                            
                        }
                    
                        .tag(1)
                        .transition(.slide)
                        .animation(.easeInOut, value: selectedTab)
                    UserPage()
                    
                        .tabItem {
                            
                            Image(systemName: "person")
                            
                            Text("User")
                        }
                        .tag(2)
                        .transition(.slide)
                        .animation(.easeInOut, value: selectedTab)
                    
                    
                    
                    //read the location first, then fetch the data from yelp
                }
                .accentColor(colorScheme == .dark ? .white : .black)

                
            }
        }
        
        .onChange(of: locationManager.location) {
            
            if let location = locationManager.location, !vm.isDataLoaded {
                
                vm.loadData(dataType: .business, searchText: "Restaurant", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                
                vm.loadData(dataType: .arcade,searchText: "Arcade", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                
            }
           
        }
        
        
    }
}
           
            


        



#Preview {  
   HomePage().environmentObject(ApiData())

}
