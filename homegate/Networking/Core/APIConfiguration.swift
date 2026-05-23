//
//  APIConfiguration.swift
//  homegate
//
//  Created by Phai Hoang on 21/5/26.
//

import Foundation

struct APIConfiguration {
    let baseURL: URL
    let defaultTimeoutInterval: TimeInterval
    let defaultHeaders: [HTTPHeader]

    static func from(_ environment: Environment) -> APIConfiguration {
        APIConfiguration(
            baseURL: environment.baseURL,
            defaultTimeoutInterval: environment.defaultTimeoutInterval,
            defaultHeaders: Self.buildDefaultHeaders()
        )
    }

    private static func buildDefaultHeaders() -> [HTTPHeader] {

        return [
            .accept("application/json"),
            .contentType("application/json"),
            HTTPHeader(field: "X-Platform", value: "iOS"),
            HTTPHeader(field: "Accept-Language", value: Locale.preferredLanguages.first ?? "en"),
        ]
    }
}
