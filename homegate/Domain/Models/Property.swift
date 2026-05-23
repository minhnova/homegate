//
//  Property.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import Foundation

struct Property: Identifiable, Equatable, Sendable {
    let id: String
    let title: String
    let listingType: ListingType
    let offerType: OfferType
    let categories: [PropertyCategory]
    let buyPrice: Decimal?
    let rentPrice: Decimal?
    let currency: String
    let address: PropertyAddress
    let characteristics: PropertyCharacteristics
    let imageURLs: [URL]
    let hasVirtualTour: Bool
    let listerName: String?
    let listerLogoURL: URL?
    let listerPhone: String?
    var isLiked: Bool
}

enum ListingType: String, Equatable, Sendable {
    case top      = "TOP"
    case standard = "STANDARD"
    case basic    = "BASIC"
    case unknown
}

enum OfferType: String, Equatable, Sendable {
    case buy  = "BUY"
    case rent = "RENT"
    case unknown
}

enum PropertyCategory: String, Equatable, Sendable {
    case house            = "HOUSE"
    case singleHouse      = "SINGLE_HOUSE"
    case chalet           = "CHALET"
    case castle           = "CASTLE"
    case multipleDwelling = "MULTIPLE_DWELLING"
    case unknown
}

struct PropertyAddress: Equatable, Sendable {
    let street: String?
    let postalCode: String?
    let locality: String?
    let region: String?
    let country: String?
    let coordinate: PropertyCoordinate?
}

struct PropertyCoordinate: Equatable, Sendable {
    let latitude: Double
    let longitude: Double
}

struct PropertyCharacteristics: Equatable, Sendable {
    let numberOfRooms: Double?
    let livingSpace: Double?
    let lotSize: Double?
    let totalFloorSpace: Double?
}
