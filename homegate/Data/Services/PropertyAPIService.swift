//
//  PropertyAPIService.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

protocol PropertyAPIServiceProtocol {
    func fetchProperties() async throws -> [PropertyResultDTO]
}

final class PropertyAPIService: PropertyAPIServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func fetchProperties() async throws -> [PropertyResultDTO] {
        let response: PropertyListResponseDTO = try await httpClient.send(PropertyEndpoint.fetchProperties)
        return response.results
    }
}
