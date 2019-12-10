//
//  Storage.swift
//  GTUserDefaults
//
//  Created by Gesantung on 2019/12/10.
//  Copyright © 2019 iOSTips. All rights reserved.
//

import Foundation

extension Key {
    static let isFirstLaunch: Key = "isFirstLaunch"
}

struct Storage {
    @UserDefault(key: .isFirstLaunch)
    var isFirstLaunch: Bool
}
