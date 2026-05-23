//
//  APIRequest.swift
//  homegate
//
//  Created by Phai Hoang on 21/5/26.
//

import Foundation

protocol APIRequest {
    associatedtype Response: Decodable

    var path: String { get }
    var method: HTTPMethod { get }
    var additionalHeaders: [HTTPHeader] { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var requiresAuth: Bool { get }
    var timeoutInterval: TimeInterval? { get }
}

extension APIRequest {
    var additionalHeaders: [HTTPHeader] { [] }
    var queryItems: [URLQueryItem]?     { nil }
    var body: Data?                     { nil }
    var requiresAuth: Bool              { true }
    var timeoutInterval: TimeInterval?  { nil }

    func buildURLRequest(
        baseURL: URL,
        defaultHeaders: [HTTPHeader],
        defaultTimeout: TimeInterval
    ) throws -> URLRequest {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: true
        )
        components?.queryItems = queryItems?.isEmpty == false ? queryItems : nil
        guard let url = components?.url else { throw NetworkError.invalidURL }

        var request = URLRequest(url: url, timeoutInterval: timeoutInterval ?? defaultTimeout)
        request.httpMethod = method.rawValue
        request.httpBody = body

        let mergedHeaders = merge(defaults: defaultHeaders, overrides: additionalHeaders)
        mergedHeaders.forEach { request.setValue($0.value, forHTTPHeaderField: $0.field) }

        return request
    }

    private func merge(defaults: [HTTPHeader], overrides: [HTTPHeader]) -> [HTTPHeader] {
        var result: [String: HTTPHeader] = Dictionary(
            uniqueKeysWithValues: defaults.map { ($0.field.lowercased(), $0) }
        )

        overrides.forEach { result[$0.field.lowercased()] = $0 }
        return Array(result.values)
    }
}
