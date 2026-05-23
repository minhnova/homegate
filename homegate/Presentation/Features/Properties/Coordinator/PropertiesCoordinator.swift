//
//  PropertiesCoordinator.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import SwiftUI

enum PropertiesRoute: Hashable {
    case detail(propertyId: String)
}

@Observable
final class PropertiesCoordinator {
    var path = NavigationPath()

    func showDetail(_ propertyId: String) {
        path.append(PropertiesRoute.detail(propertyId: propertyId))
    }
}
