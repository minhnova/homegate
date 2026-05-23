//
//  PropertyEndpoint.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

enum PropertyEndpoint: APIRequest {
    case fetchProperties

    typealias Response = PropertyListResponseDTO

    var path: String {
        switch self {
        case .fetchProperties:
            return "/properties"
        }
    }

    var method: HTTPMethod { .get }
}
