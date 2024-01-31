//
//  MainPage.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/17/23.
//

import SwiftUI

struct MainPage: View {
    @Binding  var businesses: [business]

    @Binding  var selectedTab: Int
    @Binding  var searchText: String
    @EnvironmentObject var vm: ApiData

    let CategoryIcon: [String] = ["chineseFood","hotPot","steak","salad"]

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack{
            ScrollView{
            VStack{
                Button(action: {
                    selectedTab = 1

                }, label: {
                    SearchBar(searchText: $searchText,selectedTab: $selectedTab)
                })
                    
                    
                VStack {
                    Text("Cuisine :")
                        .font(.system(size: 25))
                        .font(.subheadline)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        ForEach (CategoryIcon, id: \.self) { Icon in
                            Button {
                                selectedTab = 1
                                searchText = "\(Icon)"
                                
                            } label: {
                                VStack{
                                    Image ("\(Icon)")
                                        .resizable()
                                        .frame(width: 70,height: 70)
                                        .clipShape(Circle())
                                    Text("\(Icon)")
                                            .font(.headline)
                                            .foregroundStyle(colorScheme == .dark ? .white : .black)
                                            .lineLimit(1)
                                }
                                .padding(10)
                                
                            }
                            
                        }
                    }

                    Text("Recommened : ")
                        .font(.system(size: 28))
                        .font(.headline)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    HorizontalScrollView(businesses: vm.businesses)
           
                    Text("Arcade: " )
                        .font(.system(size: 28))
                        .font(.headline)
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HorizontalScrollView(businesses: vm.Arcade)


                }
                
                
                Spacer()
                
            }
        }
//            .background(Color.orange    .opacity(0.3).edgesIgnoringSafeArea(.all))
            

            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        Button(action:{ selectedTab = 2 }, label: {
                            Image(systemName: "person.circle")
                                .resizable()
                                .font(.system(size: 29))
                            
                        }
                        )
                        
                    }
                }
            .onAppear {
                DispatchQueue.main.async {
                    self.searchText = ""
                }
            }   
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
            
    }
    
}

struct HorizontalScrollView: View {
    var businesses: [business]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false)
        {
            HStack {
                //aviod loading the empty array
                if !businesses.isEmpty {
                    ForEach(businesses.prefix(4)) {
                        business in
                        CardView(name: business.name, rating: business.rating, imageURL: business.imageURL)
                            .containerRelativeFrame(.horizontal,count:2 , spacing: 10)
                    }
                }
                
            }
            .scrollTargetLayout()
        }
        .contentMargins(2, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}
