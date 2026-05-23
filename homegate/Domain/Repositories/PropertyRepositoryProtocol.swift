//
//  PropertyRepositoryProtocol.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

protocol PropertyRepositoryProtocol: Sendable {
    func fetchProperties() async throws -> [Property]
    func toggleLike(for propertyID: String) async throws -> Bool
    func likedPropertyIDs() -> Set<String>
}
