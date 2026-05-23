//
//  PropertyListViewModel.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

@MainActor
@Observable
final class PropertyListViewModel {
    
    private(set) var viewState: PropertyListViewState = .idle
    private let fetchPropertiesUseCase: FetchPropertiesUseCaseProtocol
    private let toggleLikeUseCase: ToggleLikeUseCaseProtocol
    private let coordinator: PropertiesCoordinator

    private var properties: [Property] = []

    init(fetchPropertiesUseCase: FetchPropertiesUseCaseProtocol,
         toggleLikeUseCase: ToggleLikeUseCaseProtocol,
         coordinator: PropertiesCoordinator) {
        self.fetchPropertiesUseCase = fetchPropertiesUseCase
        self.toggleLikeUseCase = toggleLikeUseCase
        self.coordinator = coordinator
    }

    func loadProperties() async {
        viewState = .loading
        do {
            properties = try await fetchPropertiesUseCase.execute()
            viewState = .loaded(properties)
        } catch let networkError as NetworkError {
            handleLoadError(networkError)
        } catch {
            handleLoadError(nil)
        }
    }
    
    private func handleLoadError(_ networkError: NetworkError?) {
        let viewError = networkError.map { ViewError(from: $0) } ?? .unknown

        viewState = .error(viewError)
    }
    
    func loadPropertiesIfNeeded() async {
        guard properties.isEmpty else { return }
        await loadProperties()
    }

    func toggleLike(for property: Property) async {
        if let index = properties.firstIndex(where: { $0.id == property.id }) {
            properties[index].isLiked.toggle()
            viewState = .loaded(properties)
        }
        do {
            let confirmed = try await toggleLikeUseCase.execute(propertyID: property.id)

            if let index = properties.firstIndex(where: { $0.id == property.id }) {
                properties[index].isLiked = confirmed
                viewState = .loaded(properties)
            }
        } catch {
            if let index = properties.firstIndex(where: { $0.id == property.id }) {
                properties[index].isLiked = property.isLiked
                viewState = .loaded(properties)
            }
        }
    }
    
    func didSelectProperty(_ property: Property) {
        coordinator.showDetail(property.id)
    }
}
