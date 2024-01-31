//
//  detailPage.swift
//  YumHunt
//
//  Created by Zicheng Tan on 1/19/24.
//

import SwiftUI

//using uikit component to implement the share function
struct ShareSheet: UIViewControllerRepresentable {
    
    var links: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: links, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}

struct detailPage: View {
    @State var isFavorite : Bool = false
    @State private var showShareSheet = false
    @StateObject var coreDataVM = coreDataviewModel()
    var categoriesString: String {
            business.categories.map { $0.title }.joined(separator: ", ")
        }
    let business: business

    var body: some View {
        VStack{
            HStack{
                Text("\(business.name)")
                    .font(.title)
                    .fontWeight(.semibold)
                
            }
          Divider()
            
            AsyncImage(url: URL(string: business.imageURL )) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 330, height: 350)

                    }else if phase.image == nil {
                        ProgressView()
                    }
                    else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width:200, height: 200)
                    }
                }
           Divider()
            VStack(alignment: .leading, spacing: 10) {
                Text("Address: \(business.location.address1), \(business.location.city), \(business.location.state), \(business.location.zipCode)")
                    .font(.headline)
                Text("Category: \(categoriesString)")
                    .font(.headline)
                
                
                HStack {
                   
                    Text("Ratting: \(String(format: "%.1f",business.rating))")
                        .font(.headline)

                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("  (\(business.reviewCount) review count)")
                        .font(.subheadline)
                    
                }
            }
                    .padding()

            HStack(spacing: 50) {
                    VStack{
                        Button{
                            isFavorite.toggle()
                            
                            if coreDataVM.addBusiness(business: business) {
                                print("added animal successfully")
                            }else {
                                print("you have to login first")
                            }
                        } label: {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .renderingMode(.original)
                                .imageScale(.large)
                        }
                        Text("Save")
                    }
                    VStack{
                        Button{
                            
                            openInAppleMaps(latitude: business.coordinates.latitude , longitude: business.coordinates.longitude)

                        } label: {
                            Image(systemName: "location.fill")
                                .renderingMode(.original)
                                .imageScale(.large)
                        }
                        Text("Location")
                    }
                    VStack{
                        Button{
                            self.showShareSheet = true
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .renderingMode(.original)
                                .imageScale(.large)
                        }
                        Text("Share")
                    }
                
                Divider()
                
                Button {
                    //Go to link
                } label: {
                    Image(systemName: "link.circle")
                        .renderingMode(.original)
                        .imageScale(.large)
                }

                    
                    }
            .padding()
            
            
         
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(links: ["\(business.url)"])
               }
    }
    private func openInAppleMaps(latitude: Double, longitude: Double) {
            let urlStr = "http://maps.apple.com/?ll=\(latitude),\(longitude)"
            if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
}
    

