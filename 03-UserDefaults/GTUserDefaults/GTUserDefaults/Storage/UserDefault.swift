//
//  UserDefault.swift
//  GTUserDefaults
//
//  Created by Gesantung on 2019/12/10.
//  Copyright © 2019 iOSTips. All rights reserved.
//

import Foundation


@propertyWrapper
struct UserDefault<T: PropertyListValue> {
    let key: Key

    var wrappedValue: T? {
        get { UserDefaults.standard.value(forKey: key.rawValue) as? T }
        set { UserDefaults.standard.set(newValue, forKey: key.rawValue) }
    }

    var projectedValue: UserDefault<T> { return self }

    func observe(change: @escaping (T?, T?) -> Void) -> DefaultsObservation {
        return DefaultsObservation(key: key) { old, new in
            change(old as? T, new as? T)
        }
    }
}

protocol PropertyListValue {}

extension Data: PropertyListValue {}
extension String: PropertyListValue {}
extension Date: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}

// Every element must be a property-list type
extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}

struct Key: RawRepresentable {
    let rawValue: String
}

extension Key: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}

class DefaultsObservation: NSObject {
    let key: Key
    private var onChange: (Any, Any) -> Void

    // 1
    init(key: Key, onChange: @escaping (Any, Any) -> Void) {
        self.onChange = onChange
        self.key = key
        super.init()
        UserDefaults.standard.addObserver(self, forKeyPath: key.rawValue, options: [.old, .new], context: nil)
    }

    // 2
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change, object != nil else { return }
        onChange(change[.oldKey] as Any, change[.newKey] as Any)
    }

    // 3
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: key.rawValue, context: nil)
    }
}
