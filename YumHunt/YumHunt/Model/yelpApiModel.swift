//
//  yelpApiModel.swift
//  YumHunt
//
//  Created by Zicheng Tan on 12/19/23.
//

import Foundation

struct AllBusiness : Codable {
    let businesses: [business]
}

// MARK: - Business
struct business: Codable, Identifiable {
    let rating: Double
    let price: String?
    let phone, id: String
    let categories: [Category]
    let reviewCount: Int
    let name: String
    let url: String
    let coordinates: Coordinates
    let imageURL: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case rating, price, phone, id, categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case location
    }
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - Location
struct Location: Codable {
    let city, country: String
    let address2: String?
    let address3: String?
    let state, address1, zipCode: String

    enum CodingKeys: String, CodingKey {
        case city, country, address2, address3, state, address1
        case zipCode = "zip_code"
    }
}
