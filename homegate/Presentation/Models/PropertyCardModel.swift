//
//  PropertyCardModel.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import Foundation

struct PropertyCardModel: Identifiable, Equatable {
    let id: String
    let name: String
    let offerLabel: String
    let price: String?
    let specificationsDisplayLine: String
    let address: String
    let imageURLs: [URL]
    let isLiked: Bool
    
    init(property: Property) {
        id = property.id
        name = property.title.isEmpty ? "" : property.title
        offerLabel = Self.formatOfferLabel(property.offerType)
        price = Self.formatDisplayPrice(for: property)
        specificationsDisplayLine = Self.formatSpecifications(
            rooms: property.characteristics.numberOfRooms,
            space: property.characteristics.livingSpace
        )
        address = Self.formatAddress(from: property.address)
        imageURLs = property.imageURLs
        isLiked = property.isLiked
    }
    
    private static func formatSpecifications(rooms: Double?, space: Double?) -> String {
        let formattedRooms = formatRooms(rooms)
        let formattedSpace = formatLivingSpace(space)
        
        return [formattedRooms, formattedSpace]
            .filter { !$0.isEmpty }
            .joined(separator: " / ")
    }
    
    private static func formatLivingSpace(_ space: Double?) -> String {
        guard let space, space > 0 else { return "" }
        
        let valueString: String
        if space.rounded() == space {
            valueString = "\(Int(space))"
        } else {
            valueString = "\(space)"
        }
        
        return "\(valueString) m²"
    }
    
    private static func formatAddress(from address: PropertyAddress) -> String {
        
        let postalAndLocality = [address.postalCode, address.locality]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .joined(separator: " ")
        
        let finalAddressLine = [address.street, postalAndLocality]
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
        
        return finalAddressLine
    }
    
    private static func formatOfferLabel(_ offerType: OfferType) -> String {
        switch offerType {
        case .buy:
            return "For sale"
        case .rent:
            return "For rent"
        case .unknown:
            return ""
        }
    }
    
    private static func formatDisplayPrice(for property: Property) -> String? {
        switch property.offerType {
        case .buy:
            return formatPrice(
                property.buyPrice,
                currency: property.currency,
                suffix: nil
            )
            
        case .rent:
            return formatPrice(
                property.rentPrice,
                currency: property.currency,
                suffix: "/ month"
            )
            
        case .unknown:
            if let buyPrice = property.buyPrice {
                return formatPrice(
                    buyPrice,
                    currency: property.currency,
                    suffix: nil
                )
            }
            
            if let rentPrice = property.rentPrice {
                return formatPrice(
                    rentPrice,
                    currency: property.currency,
                    suffix: "/ month"
                )
            }
            
            return nil
        }
    }
    
    private static func formatPrice(_ price: Decimal?, currency: String, suffix: String?) -> String? {
        guard let price else { return nil }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.maximumFractionDigits = 0
        
        let formattedPrice = formatter.string(from: price as NSDecimalNumber)
        ?? "\(currency) \(price)"
        
        if let suffix {
            return "\(formattedPrice) \(suffix)"
        }
        
        return formattedPrice
    }
    
    private static func formatRooms(_ rooms: Double?) -> String {
        guard let rooms else { return "" }
        
        let valueString: String
        if rooms.rounded() == rooms {
            valueString = "\(Int(rooms))"
        } else {
            valueString = "\(rooms)"
        }
        
        let suffix = (rooms == 1.0) ? "room" : "rooms"
        
        return "\(valueString) \(suffix)"
    }
}
