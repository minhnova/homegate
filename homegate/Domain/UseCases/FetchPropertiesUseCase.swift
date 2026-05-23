//
//  FetchPropertiesUseCase.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

protocol FetchPropertiesUseCaseProtocol {
    func execute() async throws -> [Property]
}

final class FetchPropertiesUseCase: FetchPropertiesUseCaseProtocol {
    private let repository: PropertyRepositoryProtocol

    init(repository: PropertyRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Property] {
        let properties = try await repository.fetchProperties()
        return properties
    }
}
