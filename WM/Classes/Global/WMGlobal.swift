//
//  WBGlobal.swift
//  WM
//
//  Created by mac-admin on 10/26/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import UIKit

class WMGlobal: NSObject {
    
    // Show Alert
    static func showAlert(title: String, message: String, target: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) {action in
            
        })
        target.present(alertController, animated: true)
    }
    
    // Save UserData
    static func saveUserData(userData: [String: Any?]) {
        print("saveUserData: \(String(describing: userData))") // DEBUG
        let userDefault = UserDefaults(suiteName: "group.com.mobile.waybackmachine")
        let encodedObject = try? NSKeyedArchiver.archivedData(withRootObject: userData, requiringSecureCoding: false)
        //let encodedObject = try? JSONEncoder().encode(userData) // doesn't work with Any types
        userDefault?.set(encodedObject, forKey: "UserData")
        userDefault?.synchronize()
    }
    
    //Get UserData
    static func getUserData() -> [String: Any?]? {
        let userDefault = UserDefaults(suiteName: "group.com.mobile.waybackmachine")
        if let encodedData = userDefault?.data(forKey: "UserData") {
            do {
                let obj = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSObject.self], from: encodedData) as? [String: Any?]

                // I tried using NSDictionary.self, but that gave this error:
                //  value for key 'NS.objects' was of unexpected class 'NSHTTPCookie
                // NSObject.self worked, but might not in the future? This was in the log:
                //  NSSecureCoding allowed classes list contains [NSObject class], which bypasses security by allowing any Objective-C class to be implicitly decoded. Consider reducing the scope of allowed classes during decoding by listing only the classes you expect to decode, or a more specific base class than NSObject. This will be disallowed in the future.
                // Also tried this, but it doesn't work with Any types:
                //let obj = try JSONDecoder().decode(Dictionary<String, Any?>.self, from: encodedData)
                print("getUserData: \(String(describing: obj))") // DEBUG
                return obj
            } catch {
                print("getUserData error: \(error)") // DEBUG
            }
        }
        return nil
    }
    
    static func isLoggedIn() -> Bool {
        if let userData = self.getUserData(),
            let isLoggedin = userData["logged-in"] as? Bool,
            isLoggedin == true {
            return true
        }
        return false
    }
    
    static func adjustNavBarHeight(constraint: NSLayoutConstraint) {
        let screenHeight = UIScreen.main.nativeBounds.height
        
        // FIXME: you can tell this ain't future-proof!
        if screenHeight != 2436,
            screenHeight != 2688,
            screenHeight != 1792 {
            constraint.constant = 60
        }
    }
}
