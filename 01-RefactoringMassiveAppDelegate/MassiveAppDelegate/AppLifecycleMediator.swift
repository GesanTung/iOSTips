//
//  AppLifecycleMediator.swift
//  MassiveAppDelegate
//
//  Created by Gesantung on 2018/8/30.
//  Copyright © 2018年 Gesantung. All rights reserved.
//
import UIKit
// MARK: - AppLifecycleListener
protocol AppLifecycleListener {
    func onAppWillEnterForeground()
    func onAppDidEnterBackground()
    func onAppDidFinishLaunching()
}

extension  AppLifecycleListener {
    func onAppWillEnterForeground() {}
    func onAppDidEnterBackground() {}
    func onAppDidFinishLaunching() {}
}

class VideoListener: AppLifecycleListener {
    func onAppDidEnterBackground() {
        //停止视频播放
    }
}

class SocketListener: AppLifecycleListener {
    func onAppWillEnterForeground() {
        //开启长连接
    }
}

// MARK: - Mediator
class AppLifecycleMediator: NSObject {
    private let listeners: [AppLifecycleListener]

    init(listeners: [AppLifecycleListener]) {
        self.listeners = listeners
        super.init()
        subscribe()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(onAppWillEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAppDidEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAppDidFinishLaunching), name: .UIApplicationDidFinishLaunching, object: nil)
    }

    @objc private func onAppWillEnterForeground() {
        listeners.forEach { $0.onAppWillEnterForeground() }
    }

    @objc private func onAppDidEnterBackground() {
        listeners.forEach { $0.onAppDidEnterBackground() }
    }

    @objc private func onAppDidFinishLaunching() {
        listeners.forEach { $0.onAppDidFinishLaunching() }
    }
}

extension AppLifecycleMediator {
    static func makeDefaultMediator() -> AppLifecycleMediator {
        let listener1 = VideoListener()
        let listener2 = SocketListener()
        return AppLifecycleMediator(listeners: [listener1, listener2])
    }
}
