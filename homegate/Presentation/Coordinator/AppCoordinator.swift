//
//  AppCoordinator.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

enum Tab {
    case properties, profile
}

struct AppCoordinatorView: View {
    @State private var selectedTab: Tab = .properties

    private let dependencies: AppDependencies

    init(dependencies: AppDependencies) {
        self.dependencies = dependencies
    }

    var body: some View {
        TabView(selection: $selectedTab) {

            PropertiesFlowView(dependencies: dependencies)
                .tabItem {
                    Label("Properties", systemImage: "house")
                }
                .tag(Tab.properties)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.profile)
        }
    }
}

