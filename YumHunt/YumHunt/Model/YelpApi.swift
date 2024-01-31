//
//  YelpApi.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/13/23.
//

import Foundation

enum AppError : Error {
    case invailURL
    case invailToken
    case invailRequest
    case invailHttpResponse
}

let apiKey = "2GqzM00rj8ydDPqjArWzR7DKi0hJRUI0rKaeIcdW1IoswekUNi8tYo8NzjDspSS1JNnqZZGMa8atI9GFNUeCkd08YLjHE33F96ug2fAC8MP2-bmWlLLLqXA1IAF6ZXYx"

let endpoint = "https://api.yelp.com/v3"

struct Service {
    
    func fetchYelpData (searchText : String, latitude: Double,longitude: Double) async throws -> AllBusiness {

        print("latitude: \(latitude)  , longitude: \(longitude)")
        guard let url = URL(string: "\(endpoint)/businesses/search?term=\(searchText)&latitude=\(latitude)&longitude=\(longitude)") else{
            throw AppError.invailURL
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        //check for service status code
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                   throw AppError.invailHttpResponse
               }
        
        let decoder = JSONDecoder()

        
        return try decoder.decode(AllBusiness.self, from: data)
    }
}
