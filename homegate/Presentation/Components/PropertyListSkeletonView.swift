//
//  PropertyListSkeletonView.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

struct PropertyListSkeletonView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(0..<3, id: \.self) { _ in
                    SkeletonCardView()
                        .padding(.horizontal, 16)
                }
            }
            .padding(.vertical, 16)
        }
        .disabled(true)
    }
}

struct SkeletonCardView: View {
    @State private var animating = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(maxWidth: .infinity)
                .frame(height: 240)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 220, height: 12)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 160, height: 12)
        }
        .opacity(animating ? 0.5 : 1.0)
        .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true), value: animating)
        .onAppear { animating = true }
    }
}

#Preview("Property List Skeleton") {
    NavigationStack {
        PropertyListSkeletonView()
            .navigationTitle("Properties")
    }
}

#Preview("Skeleton Row") {
    ScrollView {
        SkeletonCardView()
            .padding(16)
    }
}
