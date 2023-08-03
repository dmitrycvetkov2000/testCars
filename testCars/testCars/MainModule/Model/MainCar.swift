//
//  MainCar.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import Foundation

// MARK: - MainCar
struct MainCar: Decodable {
    let id, forSale: Int?
    let brandName, modelName, engineName: String?
    let year: Int?
    let price: JSONNull?
    let brandID, modelID, engineID, transmissionID: Int?
    let placeID, name: String?
    let image, thumbnail: String?
    let cityName, countryName: String?
    let transmissionName: TransmissionName?
    let engineVolume, placeName: String?
    let images: [Image]?
    let engine: String?

    enum CodingKeys: String, CodingKey {
        case id
        case forSale = "for_sale"
        case brandName = "brand_name"
        case modelName = "model_name"
        case engineName = "engine_name"
        case year, price
        case brandID = "brand_id"
        case modelID = "model_id"
        case engineID = "engine_id"
        case transmissionID = "transmission_id"
        case placeID = "place_id"
        case name, image, thumbnail
        case cityName = "city_name"
        case countryName = "country_name"
        case transmissionName = "transmission_name"
        case engineVolume = "engine_volume"
        case placeName = "place_name"
        case images, engine
    }
}

// MARK: - Image
struct Image: Decodable {
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

enum TransmissionName: String, Decodable {
    case at = "AT"
    case mt = "MT"
}

typealias MainCars = [MainCar]

// MARK: - Encode/decode helpers

class JSONNull: Decodable, Hashable {

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
