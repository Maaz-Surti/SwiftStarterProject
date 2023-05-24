//
//  PersistentData.swift
//  Barred
//
//  Created by RCD on 24/05/2023.
//

import Foundation
import UIKit

extension UserDefaults {
    
    static let UserDefault = UserDefaults.standard    
}


private enum Keys {
    
    static let isFirstLaunch = "isFirstLaunch"
    
    static let isUserLoggedIn = "isUserLoggedIn"
    
    static let username = "username"
    
    static let userPhoneNumber = "userPhoneNumber"
    
    static let userEmail = "userEmail"
    
    static let isArabic = "isArabic"
    
    static let userID = "userID"
}

var isUserLoggedIn: Bool {
    
    get {  return UserDefaults.standard.bool(forKey: Keys.isUserLoggedIn) }
    set {  UserDefaults.standard.set(newValue, forKey: Keys.isUserLoggedIn) }
}

var username: String {
    
    get {  return UserDefaults.standard.string(forKey: Keys.username) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: Keys.username) }
}

var userPhoneNumber: String {
    
    get { return UserDefaults.standard.string(forKey: Keys.userPhoneNumber) ?? "" }
    set { UserDefaults.standard.set(newValue, forKey: Keys.userPhoneNumber) }
}

var userID: String {
    
    get { return UserDefaults.standard.string(forKey: Keys.userID) ?? ""}
    set { UserDefaults.standard.set(newValue, forKey: Keys.userID) }
}

var userEmail: String {
    
    get { return UserDefaults.standard.string(forKey: Keys.userEmail) ?? ""  }
    set { UserDefaults.standard.set(newValue, forKey: Keys.userEmail) }
}

var isArabic: Bool {
    
    get { return UserDefaults.standard.bool(forKey: Keys.isArabic) }
    set { UserDefaults.standard.set(newValue, forKey: Keys.isArabic) }
}

///For checking if the application is being launched for the first time
func isFirstLaunch() -> Bool {
    
    if !UserDefaults.standard.bool(forKey: Keys.isFirstLaunch) {
        UserDefaults.standard.set(true, forKey: Keys.isFirstLaunch)
        return true
    }
    
    return false
}
