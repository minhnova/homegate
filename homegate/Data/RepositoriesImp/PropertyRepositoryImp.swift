//
//  PropertyRepositoryImp.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

final class PropertyRepositoryImp: PropertyRepositoryProtocol {
    private let apiService: PropertyAPIServiceProtocol
    private let localDataSource: LikesLocalDataSourceProtocol
    
    init(apiService: PropertyAPIServiceProtocol,
         localDataSource: LikesLocalDataSourceProtocol) {
        self.apiService = apiService
        self.localDataSource = localDataSource
    }
    
    func fetchProperties() async throws -> [Property] {
        
        let results = try await apiService.fetchProperties()
        let liked = localDataSource.likedIDs()
        return results.map { $0.toDomain(isLiked: liked.contains($0.id)) }

         // Uncomment this code below to test network error
//        try await Task.sleep(for: .seconds(2))
//        throw NetworkError.serverError(statusCode: 201, data: nil)
    }
    
    func toggleLike(for propertyID: String) async throws -> Bool {
        let newState = !localDataSource.likedIDs().contains(propertyID)
        localDataSource.setLiked(propertyID, liked: newState)
        return newState
    }
    
    func likedPropertyIDs() -> Set<String> {
        localDataSource.likedIDs()
    }
}
