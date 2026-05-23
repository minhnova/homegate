//
//  AppDependencies.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import Foundation

final class AppDependencies {
    private let configuration = APIConfiguration.from(.current)
    
    lazy var httpClient: HTTPClientProtocol = HTTPClient(configuration: configuration)

    lazy var propertyAPIService: PropertyAPIServiceProtocol =
        PropertyAPIService(httpClient: httpClient)
    
    lazy var likesLocalDataSource: LikesLocalDataSourceProtocol =
        UserDefaultsLikesStore()

    lazy var propertyRepository: PropertyRepositoryProtocol = PropertyRepositoryImp(
        apiService: propertyAPIService,
        localDataSource: likesLocalDataSource
    )

    // MARK: - Use Cases
    lazy var fetchPropertiesUseCase: FetchPropertiesUseCaseProtocol =
        FetchPropertiesUseCase(repository: propertyRepository)
    lazy var toggleLikeUseCase: ToggleLikeUseCaseProtocol =
        ToggleLikeUseCase(repository: propertyRepository)

    // MARK: - ViewModels
    @MainActor
    func makePropertyListViewModel(
        coordinator: PropertiesCoordinator,
        onShowProfile: ((String) -> Void)? = nil
    ) -> PropertyListViewModel {
        PropertyListViewModel(
            fetchPropertiesUseCase: fetchPropertiesUseCase,
            toggleLikeUseCase: toggleLikeUseCase,
            coordinator: coordinator
        )
    }
}
