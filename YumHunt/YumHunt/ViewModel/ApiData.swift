    //
    //  ApiData.swift
    //  YumHunt
    //
    //  Created by Zicheng Tan on 12/22/23.
    //

    import Foundation

    enum DataType {
    case business
    case arcade
    case search
    }

    enum Behavior {
        case logOut
        case collection
        case `default`
    }

    class ApiData: ObservableObject {
        @Published var businesses: [business] = []
        @Published var Arcade: [business] = []
        @Published var isDataLoaded = false
        @Published var searchResults: [business] = []
        @Published var isArcadeDataLoaded = false

        private let service = Service()
        
        func loadData(dataType: DataType, searchText: String, latitude: Double, longitude: Double) {
            Task {
                do {
                    let fetchedData = try await service.fetchYelpData(searchText: searchText, latitude: latitude, longitude: longitude)
                    DispatchQueue.main.async {
                        switch dataType{
                        case .business :
                            self.businesses = fetchedData.businesses
                            self.isDataLoaded = true
                            print(self.businesses)
                        case .arcade :
                            self.Arcade = fetchedData.businesses
                            self.isArcadeDataLoaded = true
                        case .search :
                            self.searchResults = fetchedData.businesses
                        }
                    }

                } catch {
                    
                    print("Error when Fetching data \(error)")
                    
                }
            }
        }
    }
