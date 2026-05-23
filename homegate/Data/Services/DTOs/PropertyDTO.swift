//
//  PropertyDTO.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import Foundation

struct PropertyListResponseDTO: Decodable {
    let from: Int
    let size: Int
    let total: Int
    let results: [PropertyResultDTO]
    let maxFrom: Int
}

struct PropertyResultDTO: Decodable {
    let id: String
    let remoteViewing: Bool
    let listingType: ListingTypeDTO
    let listerBranding: ListerBrandingDTO?
    let listing: ListingDTO
}

struct ListingTypeDTO: Decodable {
    let type: String
}

struct ListerBrandingDTO: Decodable {
    let logoUrl: String?
    let legalName: String?
    let name: String?
    let address: AddressDTO?
    let adActive: Bool?
    let isQualityPartner: Bool?
    let isPremiumBranding: Bool?
    let profilePageUrlKeyword: String?
}

struct ListerDTO: Decodable {
    let phone: String?
    let logoUrl: String?
}

struct ListingDTO: Decodable {
    let id: String
    let offerType: String
    let categories: [String]
    let prices: PricesDTO
    let address: AddressDTO
    let characteristics: CharacteristicsDTO
    let localization: LocalizationDTO
    let lister: ListerDTO?
}

struct PricesDTO: Decodable {
    let currency: String?
    let buy: BuyPriceDTO?
    let rent: RentPriceDTO?
}

struct BuyPriceDTO: Decodable {
    let price: Decimal?
    let area: String?
    let interval: String?
}

struct RentPriceDTO: Decodable {
    let price: Decimal?
    let interval: String?
}

struct AddressDTO: Decodable {
    let country: String?
    let locality: String?
    let postalCode: String?
    let region: String?
    let street: String?
    let geoCoordinates: GeoCoordinatesDTO?
}

struct GeoCoordinatesDTO: Decodable {
    let latitude: Double
    let longitude: Double
}

struct CharacteristicsDTO: Decodable {
    let numberOfRooms: Double?
    let livingSpace: Double?
    let lotSize: Double?
    let totalFloorSpace: Double?
}

struct LocalizationDTO: Decodable {
    let primary: String
    let de: LocaleContentDTO?
    let fr: LocaleContentDTO?
    let en: LocaleContentDTO?
}

struct LocaleContentDTO: Decodable {
    let attachments: [AttachmentDTO]?
    let text: LocaleTextDTO?
    let urls: [ExternalUrlDTO]?
}

struct LocaleTextDTO: Decodable {
    let title: String?
    let description: String?
}

struct AttachmentDTO: Decodable {
    let type: String
    let url: String
    let file: String?
}

struct ExternalUrlDTO: Decodable {
    let type: String
    let url: String?
}

extension LocalizationDTO {
    var primaryContent: LocaleContentDTO? {
        let primaryContent: LocaleContentDTO?

        switch primary {
        case "de":
            primaryContent = de
        case "fr":
            primaryContent = fr
        case "en":
            primaryContent = en
        default:
            primaryContent = nil
        }

        return primaryContent ?? de ?? fr ?? en
    }
}

extension PropertyResultDTO {
    func toDomain(isLiked: Bool) -> Property {
        let content = listing.localization.primaryContent
        let lister = listing.lister

        let imageURLs: [URL] = (content?.attachments ?? [])
            .filter { $0.type == "IMAGE" }
            .compactMap { URL(string: $0.url) }

        let hasVirtualTour = (content?.urls ?? [])
            .contains { $0.type == "VIRTUAL_TOUR" }

        return Property(
            id: id,
            title: content?.text?.title ?? "",
            listingType: ListingType(rawValue: listingType.type) ?? .unknown,
            offerType: OfferType(rawValue: listing.offerType) ?? .unknown,
            categories: listing.categories.map {
                PropertyCategory(rawValue: $0) ?? .unknown
            },
            buyPrice: listing.prices.buy?.price,
            rentPrice: listing.prices.rent?.price,
            currency: listing.prices.currency ?? "CHF",
            address: PropertyAddress(
                street: listing.address.street,
                postalCode: listing.address.postalCode,
                locality: listing.address.locality,
                region: listing.address.region,
                country: listing.address.country,
                coordinate: listing.address.geoCoordinates.map {
                    PropertyCoordinate(
                        latitude: $0.latitude,
                        longitude: $0.longitude
                    )
                }
            ),
            characteristics: PropertyCharacteristics(
                numberOfRooms: listing.characteristics.numberOfRooms,
                livingSpace: listing.characteristics.livingSpace,
                lotSize: listing.characteristics.lotSize,
                totalFloorSpace: listing.characteristics.totalFloorSpace
            ),
            imageURLs: imageURLs,
            hasVirtualTour: hasVirtualTour,
            listerName: listerBranding?.name ?? listerBranding?.legalName,
            listerLogoURL: (listerBranding?.logoUrl ?? lister?.logoUrl)
                .flatMap { URL(string: $0) },
            listerPhone: lister?.phone,
            isLiked: isLiked
        )
    }
}
