//
//  EmptyStateView.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: icon)
        } description: {
            Text(message)
        } actions: {
            if let actionTitle, let action {
                Button(actionTitle, action: action)
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
