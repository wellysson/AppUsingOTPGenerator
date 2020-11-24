//
//  PreferencesManager.swift
//  OTPGenerator
//
//  Created by Wellysson Avelar on 16/11/20.
//

import Foundation
import UIKit

public class PreferencesManager: NSObject {
    public static var hasTouchApp = "HAS_TOUCH_APP_V2"
    @discardableResult public static func firstTime(_ key: String) -> Bool {
        let firstTime: Bool = PreferencesManager.getObject(key) ?? false
        if firstTime {
            return false
        } else {
            PreferencesManager.saveObject(key, value: true)
            return true
        }
    }
    public static func cleanObject(_ key: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(nil, forKey: key)
        defaults.synchronize()
    }
    
    public static func saveObject<T: Any>(_ key: String, value: T?) {
        let defaults: UserDefaults = UserDefaults.standard
        if value != nil {
            if let stringValue = value as? String {
                defaults.set(stringValue, forKey: key)
            } else if let stringValue = value as? NSString {
                defaults.set(stringValue, forKey: key)
            } else if let boolValue = value as? Bool {
                defaults.set(boolValue, forKey: key)
            } else if let floatValue = value as? Float {
                defaults.set(floatValue, forKey: key)
            } else if let doubleValue = value as? Double {
                defaults.set(doubleValue, forKey: key)
            } else if let integerValue = value as? NSInteger {
                defaults.set(integerValue, forKey: key)
            } else if let dataObject = value as? NSCoding {
                let encodedObject: Data = NSKeyedArchiver.archivedData(withRootObject: dataObject)
                defaults.set(encodedObject, forKey: key)
            }
        } else {
            defaults.set(nil, forKey: key)
        }
        defaults.synchronize()
    }
    
    public static func getObject<T>(_ key: String) -> T? {
        var object: T?
        let defaults: UserDefaults = UserDefaults.standard
        if T.self == String.self || T.self == NSString.self {
            object = defaults.string(forKey: key) as? T
        } else if T.self == Bool.self {
            if defaults.object(forKey: key) != nil {
                object = defaults.bool(forKey: key) as? T
            }
        } else if T.self == Float.self {
            object = defaults.float(forKey: key) as? T
        } else if T.self == Double.self {
            object = defaults.double(forKey: key) as? T
        } else if T.self == NSInteger.self {
            object = defaults.integer(forKey: key) as? T
        } else {
            let value: Data? = defaults.data(forKey: key)
            if (value?.count ?? 0) > 0 {
                object = NSKeyedUnarchiver.unarchiveObject(with: value!) as? T
            }
        }
        return object
    }
}
