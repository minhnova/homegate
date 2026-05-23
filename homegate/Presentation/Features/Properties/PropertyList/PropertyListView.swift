//
//  PropertyListView.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

struct PropertyListView: View {
    @State private var viewModel: PropertyListViewModel
    
    init(viewModel: PropertyListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        Group { content }
            .navigationTitle("Properties")
            .task {
                await viewModel.loadPropertiesIfNeeded()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
            
        case .idle:
            Color.clear
            
        case .loading:
            PropertyListSkeletonView()
            
        case .loaded(let properties):
            if properties.isEmpty {
                EmptyStateView(
                    icon: "tray",
                    title: "No Properties Yet",
                    message: "Check back later for new properties.",
                    actionTitle: "Refresh",
                    action: {
                        Task {
                            await viewModel.loadProperties()
                        }
                    }
                )
            } else {
                List(properties) { property in
                    PropertyCardView(
                        property: PropertyCardModel(property: property),
                        onLikeTapped: {
                            Task {
                                await viewModel.toggleLike(for: property)
                            }
                        },
                    )
                    .onTapGesture {
                        viewModel.didSelectProperty(property)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            
        case .error(let error):
            ErrorStateView(error: error,
                           onRetry: error.isRetryable ? {
                Task {
                    await viewModel.loadProperties()
                }
            } : nil
            )
        }
    }
}
