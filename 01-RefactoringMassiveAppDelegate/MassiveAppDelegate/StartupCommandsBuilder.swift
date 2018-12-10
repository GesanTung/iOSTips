//
//  StartupCommandsBuilder.swift
//  MassiveAppDelegate
//
//  Created by Gesantung on 2018/8/30.
//  Copyright © 2018年 Gesantung. All rights reserved.
//

import UIKit

final class StartupCommandsBuilder {
    private var window: UIWindow!

    func setKeyWindow(_ window: UIWindow) -> StartupCommandsBuilder {
        self.window = window
        return self
    }

    func build() -> [Command] {
        return [
            InitializeThirdPartiesCommand(),
            InitialViewControllerCommand(keyWindow: window),
            InitializeAppearanceCommand(),
            RegisterToRemoteNotificationsCommand()
        ]
    }
}

protocol Command {
    func execute()
}

struct InitializeThirdPartiesCommand: Command {
    func execute() {
        // Third parties are initialized here
    }
}

struct InitialViewControllerCommand: Command {
    let keyWindow: UIWindow

    func execute() {
        // Pick root view controller here
        keyWindow.rootViewController = UIViewController()
    }
}

struct InitializeAppearanceCommand: Command {
    func execute() {
        // Setup UIAppearance
    }
}

struct RegisterToRemoteNotificationsCommand: Command {
    func execute() {
        // Register for remote notifications here
    }
}

