//
//  ErrorStateView.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

struct ErrorStateView: View {
    let error: ViewError
    var onRetry: (() -> Void)?

    var body: some View {
        ContentUnavailableView {
            Label(error.title, systemImage: error.systemImage)
        } description: {
            Text(error.message)
        } actions: {
            if let onRetry {
                Button("Try Again", action: onRetry)
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview("EmptyStateView") {
    NavigationStack {
        EmptyStateView(icon: "home", title: "No properties", message: "Check again later")
            .navigationTitle("Properties")
    }
}
