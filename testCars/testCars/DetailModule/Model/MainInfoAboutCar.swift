//
//  MainInfoAboutCar.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mainInfoAboutCar = try? JSONDecoder().decode(MainInfoAboutCar.self, from: jsonData)

import Foundation

// MARK: - MainInfoAboutCar
struct MainInfoAboutCar: Codable {
    let car: Car?
    let user: User?
}

// MARK: - Car
struct Car: Codable {
    let id, forSale: Int?
    let brandName, modelName: String?
    let year: Int?
    fileprivate let price: JSONNull?
    let brandID, modelID, engineID, transmissionID: Int?
    let placeID, name, cityName, countryName: String?
    let transmissionName, placeName: String?
    let images: [Image]?
    let inSelectionCount, followersCount: Int?
    let follow: Bool?
    let engine, engineName, engineVolume: String?
    let isModerated: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case forSale = "for_sale"
        case brandName = "brand_name"
        case modelName = "model_name"
        case year, price
        case brandID = "brand_id"
        case modelID = "model_id"
        case engineID = "engine_id"
        case transmissionID = "transmission_id"
        case placeID = "place_id"
        case name
        case cityName = "city_name"
        case countryName = "country_name"
        case transmissionName = "transmission_name"
        case placeName = "place_name"
        case images
        case inSelectionCount = "in_selection_count"
        case followersCount = "followers_count"
        case follow, engine
        case engineName = "engine_name"
        case engineVolume = "engine_volume"
        case isModerated = "is_moderated"
    }
    
    // MARK: - Image
    struct Image: Codable {
        let id: Int?
        let isPrimary: Bool?
        let size, index: Int?
        let url, thumbnailURL, image500, image100: String?

        enum CodingKeys: String, CodingKey {
            case id
            case isPrimary = "is_primary"
            case size, index, url
            case thumbnailURL = "thumbnail_url"
            case image500, image100
        }
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let username, email, about: String?
    let avatar: Avatar?
    let autoCount: Int?
    let mainAutoName: String?

    enum CodingKeys: String, CodingKey {
        case id, username, email, about, avatar
        case autoCount = "auto_count"
        case mainAutoName = "main_auto_name"
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let path: String?
    let url: String?
}

// MARK: - Encode/decode helpers

fileprivate class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

