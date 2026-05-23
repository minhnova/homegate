//
//  LikesLocalDataSource.swift
//  homegate
//
//  Created by Phai Hoang on 22/5/26.
//

import Foundation

protocol LikesLocalDataSourceProtocol {
    func likedIDs() -> Set<String>
    func setLiked(_ id: String, liked: Bool)
}

final class UserDefaultsLikesStore: LikesLocalDataSourceProtocol {
    private let defaults: UserDefaults
    private let key = "com.homegate.liked_property_ids"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func likedIDs() -> Set<String> {
        Set(defaults.stringArray(forKey: key) ?? [])
    }

    func setLiked(_ id: String, liked: Bool) {
        var ids = likedIDs()
        if liked {
            ids.insert(id)
        } else {
            ids.remove(id)
        }
        defaults.set(Array(ids), forKey: key)
    }
}
