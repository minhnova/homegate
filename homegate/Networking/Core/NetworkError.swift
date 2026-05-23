//
//  NetworkError.swift
//  homegate
//
//  Created by Phai Hoang on 20/5/26.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case noInternetConnection
    case timeout
    case cancelled
    case invalidURL
    
    case unauthorized
    case forbidden
    case notFound
    
    case clientError(statusCode: Int, data: Data?)
    case serverError(statusCode: Int, data: Data?)
    
    case decodingFailed(Error)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "The internet connection appears to be offline."
        case .timeout:
            return "The request timed out. Please try again."
        case .cancelled:
            return "The request was cancelled."
        case .invalidURL:
            return "The endpoint URL is invalid."
        case .unauthorized:
            return "Session expired. Please log in again."
        case .forbidden:
            return "You don't have permission to access this resource."
        case .notFound:
            return "The requested resource could not be found."
        case .clientError(let statusCode, _):
            return "Client error occurred (\(statusCode)). Please verify your request."
        case .serverError(let statusCode, _):
            return "Server error (\(statusCode)). Please try again later."
        case .decodingFailed:
            return "Failed to process data from the server."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
