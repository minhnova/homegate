//
//  ProfileView.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(.secondary)

                Text("Guest User")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Welcome to Homegate")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
