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
        let userDefault = UserDefaults(suiteName: "group.com.mobile.waybackmachine")
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: userData)
        userDefault?.set(encodedObject, forKey: "UserData")
        userDefault?.synchronize()
    }
    
    //Get UserData
    static func getUserData() -> [String: Any?]? {
        let userDefault = UserDefaults(suiteName: "group.com.mobile.waybackmachine")
        if let encodedData = userDefault?.data(forKey: "UserData") {
            let obj = NSKeyedUnarchiver.unarchiveObject(with: encodedData)
            return obj as? [String: Any?]
        } else {
            return nil
        }
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
