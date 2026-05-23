//
//  ViewError.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

enum ViewError: Equatable {
    case noInternet
    case timeout
    case serverError
    case notFound
    case unauthorized
    case unknown

    var title: String {
        switch self {
        case .noInternet:    
            return "No Internet Connection"
        case .timeout:       
            return "Connection Timed Out"
        case .serverError:   
            return "Something Went Wrong"
        case .notFound:      
            return "Content Not Found"
        case .unauthorized:  
            return "Session Expired"
        case .unknown:       
            return "Unexpected Error"
        }
    }

    var message: String {
        switch self {
        case .noInternet:    
            return "Check your connection and try again."
        case .timeout:       
            return "The server took too long to respond. Try again."
        case .serverError:   
            return "We're having trouble on our end. Try again shortly."
        case .notFound:      
            return "This content is no longer available."
        case .unauthorized:  
            return "Please sign in again to continue."
        case .unknown:       
            return "An unexpected error occurred. Try again."
        }
    }

    var systemImage: String {
        switch self {
        case .noInternet:    
            return "wifi.slash"
        case .timeout:       
            return "clock.badge.exclamationmark"
        case .serverError:   
            return "server.rack"
        case .notFound:      
            return "questionmark.folder"
        case .unauthorized:  
            return "lock.slash"
        case .unknown:       
            return "exclamationmark.triangle"
        }
    }

    var isRetryable: Bool {
        switch self {
        case .noInternet, .timeout, .serverError, .unknown:
            return true
        case .notFound, .unauthorized:
            return false
        }
    }
}

extension ViewError {
    init(from networkError: NetworkError) {
        switch networkError {
        case .noInternetConnection:
            self = .noInternet
        case .timeout:
            self = .timeout
        case .serverError:
            self = .serverError
        case .unauthorized:
            self = .unauthorized
        case .notFound:
            self = .notFound
        default:
            self = .unknown
        }
    }
}
