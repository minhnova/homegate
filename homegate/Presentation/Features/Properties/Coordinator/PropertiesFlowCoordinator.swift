//
//  PropertiesFlowCoordinator.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

struct PropertiesFlowView: View {
    @State private var coordinator = PropertiesCoordinator()
    let dependencies: AppDependencies

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            PropertyListView(
                viewModel: dependencies.makePropertyListViewModel(
                    coordinator: coordinator
                )
            )
            .navigationDestination(for: PropertiesRoute.self) { route in
                switch route {
                case .detail(let property):
                    Text("Property detail: \(property)")
                }
            }
        }
    }
}
