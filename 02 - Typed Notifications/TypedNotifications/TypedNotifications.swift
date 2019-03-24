
//
//  TypedNotifications.swift
//  TypedNotifications
//
//  Created by Gesantung on 2019/3/24.
//  Copyright © 2019 laofeng. All rights reserved.
//

import Foundation

protocol NotificationDescriptor {
    static var name: Notification.Name { get }
    var userInfo: [AnyHashable: Any]? { get }
    var object: Any? { get }
}

extension NotificationDescriptor {

    var userInfo: [AnyHashable: Any]? {
        return nil
    }

    var object: Any? {
        return nil
    }
}

extension NotificationDescriptor {
    public func post(on center: NotificationCenter = NotificationCenter.default) {
        print(Self.name)
        center.post(name: Self.name, object: object, userInfo: userInfo)
    }
}

protocol NotificationDecodable {
    init(_ notification: Notification)
}

extension NotificationDecodable {
    @discardableResult
    public static func observer(on center: NotificationCenter = NotificationCenter.default ,
                                for aName: Notification.Name,
                                using block: @escaping (Self) -> Swift.Void) -> NotificationToken {
        let token = center.addObserver(forName: aName, object: nil, queue: nil, using: {
            block(Self.init($0))
        })
        print(aName)
        return NotificationToken.init(token, center: center)
    }
}

typealias NotificationProtocol = NotificationDescriptor & NotificationDecodable

protocol TypedNotification : NotificationProtocol {
    @discardableResult
    static func registerObserver(using block: @escaping (Self) -> Swift.Void) -> NotificationToken
}

extension TypedNotification {
    @discardableResult
    static func registerObserver(using block: @escaping (Self) -> Swift.Void) -> NotificationToken {
        return self.observer(on: NotificationCenter.default, for: Self.name, using: block)
    }
}



class NotificationToken {
    public let token: NSObjectProtocol
    public let center: NotificationCenter
    public init(_ token: NSObjectProtocol, center: NotificationCenter) {
        self.token = token
        self.center = center
    }

    deinit {
        center.removeObserver(token)
    }
}

struct VoidNotification: NotificationDecodable {
    public init(_ notification: Notification) {
    }
}

extension Notification.Name: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

