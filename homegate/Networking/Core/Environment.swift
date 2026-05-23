//
//  Environment.swift
//  homegate
//
//  Created by Phai Hoang on 21/5/26.
//

import Foundation

enum Environment {
    case development
    case production
    case staging
    
    static var current: Environment {
        guard let raw = Bundle.main.object(forInfoDictionaryKey: "APP_ENVIRONMENT") as? String
        else { return .development }
        switch raw {
        case "development":
            return .development
        case "staging":
            return .staging
        case "production":
            return .production
        default:
            return .development
        }
    }
    
    var baseURL: URL {
        switch self {
        case .development:
            return URL(string: "https://private-9f1bb1-homegate3.apiary-mock.com")!
        case .staging:
            return URL(string: "https://private-9f1bb1-homegate3.apiary-mock.com")!
        case .production:
            return URL(string: "https://private-9f1bb1-homegate3.apiary-mock.com")!
        }
    }
    
    var defaultTimeoutInterval: TimeInterval {
        switch self {
        case .development:
            return 60
        case .staging, .production:
            return 30
        }
    }
}
