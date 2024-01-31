//
//  CollectionPage.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/28/24.
//

import SwiftUI

struct CollectionPage: View {
    @StateObject var coreDataVM = coreDataviewModel()

    var body: some View {
            
            NavigationStack{
                VStack{
                    
                    
                    if let userBusiness = coreDataVM.fetchLoggedInUserBusiness() {
     
                        List(userBusiness) {
                            business in
                            Button(action: {
                                }) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .frame(width: 40, height: 40)
                                    
                                        .foregroundColor(.yellow)
                                        .padding(.trailing, 5)
                                    
                                    AsyncImage(url: URL(string: business.imageUrl ?? "")) { phase in
                                        //check phase
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                        case .empty:
                                            Image(systemName: "photo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 80, height: 80)
                                                .clipShape(Circle())
                                        case .failure(_):
                                            EmptyView()
                                        @unknown default:
                                            EmptyView()
                                        }
                                        
                                    }
                                    Text(business.name ?? "No name yet")
                                        .foregroundColor(.primary)
                                    Spacer()
                                    
                                }
                            }
                            
                            
                            .frame(width: 300, height: 120)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                        }
                    }
                    }
                
                        
                        
                        
                            .navigationBarTitle("Collection", displayMode: .automatic)
                            .padding(.horizontal, 10)
                        
            }
            .onAppear{
                DispatchQueue.main.async {
                    coreDataVM.fetchUser()
                    coreDataVM.fetchAnimal()
                }
            }
        }
}

#Preview {
    CollectionPage()
}
