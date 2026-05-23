//
//  homegateApp.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

@main
struct homegateApp: App {
    private let dependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(dependencies: dependencies)
        }
    }
}
