//
//  ToggleLikeUseCase.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

protocol ToggleLikeUseCaseProtocol {
    func execute(propertyID: String) async throws -> Bool
}

final class ToggleLikeUseCase: ToggleLikeUseCaseProtocol {
    private let repository: PropertyRepositoryProtocol

    init(repository: PropertyRepositoryProtocol) {
        self.repository = repository
    }

    func execute(propertyID: String) async throws -> Bool {
        return try await repository.toggleLike(for: propertyID)
    }
}
