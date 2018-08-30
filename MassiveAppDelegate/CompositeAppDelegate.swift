//
//  CompositeAppDelegate.swift
//  MassiveAppDelegate
//
//  Created by Gesantung on 2018/8/30.
//  Copyright © 2018年 Gesantung. All rights reserved.
//

import UIKit

enum AppDelegateFactory {
    static func makeDefault() -> AppDelegateType {
        return CompositeAppDelegate(appDelegates: [PushNotificationsAppDelegate(), StartupConfiguratorAppDelegate(), ThirdPartiesConfiguratorAppDelegate()])
    }
}

typealias AppDelegateType = UIResponder & UIApplicationDelegate

class CompositeAppDelegate: AppDelegateType {
    private let appDelegates: [AppDelegateType]

    init(appDelegates: [AppDelegateType]) {
        self.appDelegates = appDelegates
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        appDelegates.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        appDelegates.forEach { _ = $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
}

class PushNotificationsAppDelegate: AppDelegateType {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Registered successfully
    }
}

class StartupConfiguratorAppDelegate: AppDelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Perform startup configurations, e.g. build UI stack, setup UIApperance
        return true
    }
}

class ThirdPartiesConfiguratorAppDelegate: AppDelegateType {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Setup third parties
        return true
    }
}
