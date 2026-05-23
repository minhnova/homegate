//
//  CachedAsyncImage.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import Foundation
import SwiftUI

struct CachedAsyncImage: View {
    let url: URL
    @State private var image: UIImage? = nil
    @State private var isLoading = false

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .overlay {
                        if isLoading {
                            ProgressView()
                        }
                    }
            }
        }
        .task(id: url) {
            await loadImage()
        }
    }

    private func loadImage() async {
        if let cached = ImageCache.shared.image(for: url) {
            image = cached
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let loaded = UIImage(data: data) {
                ImageCache.shared.store(loaded, for: url)
                image = loaded
            }
        } catch {
        }
    }
}
