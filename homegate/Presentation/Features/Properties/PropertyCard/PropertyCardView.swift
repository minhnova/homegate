//
//  PropertyCardView.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

struct PropertyCardView: View {
    let property: PropertyCardModel
    let onLikeTapped: () -> Void
    
    @State private var currentImageIndex = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            imageCarousel
            propertyInfo
        }
        .contentShape(Rectangle())
    }
    
    private var imageCarousel: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentImageIndex) {
                ForEach(property.imageURLs.indices, id: \.self) { index in
                    CachedAsyncImage(url: property.imageURLs[index])
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            likeButton
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(12)
            
            pageDotsIndicator
                .padding(.bottom, 10)
        }
        .frame(height: 240)
    }
    
    private var likeButton: some View {
        Button(action: onLikeTapped) {
            Image(systemName: property.isLiked ? "heart.fill" : "heart")
                .foregroundStyle(property.isLiked ? .red : .white)
                .font(.title3)
                .shadow(radius: 2)
        }
        .buttonStyle(.plain)
    }
    
    private var pageDotsIndicator: some View {
        HStack(spacing: 4) {
            ForEach(property.imageURLs.indices, id: \.self) { index in
                Circle()
                    .fill(index == currentImageIndex ? Color.white : Color.white.opacity(0.5))
                    .frame(
                        width: index == currentImageIndex ? 6 : 4,
                        height: index == currentImageIndex ? 6 : 4
                    )
                    .animation(.easeInOut(duration: 0.2), value: currentImageIndex)
            }
        }
    }
    
    // MARK: - Property Info
    
    private var propertyInfo: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                
                Text(property.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                Spacer(minLength: 12)
                
                if !property.offerLabel.isEmpty {
                    Text(property.offerLabel)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }
            
            Text(property.address)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .lineLimit(2)
              
            if !property.specificationsDisplayLine.isEmpty {
                Text(property.specificationsDisplayLine)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            
            if let price = property.price {
                Text(price)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)
                    .multilineTextAlignment(.trailing)
            }
            
        }
        .padding(.horizontal, 4)
    }
}
