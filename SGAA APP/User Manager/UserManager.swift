//
//  UserManager.swift
//  FaceDoct
//
//  Created by Mina Malak on 21/06/2021.
//

import Foundation

class UserManager{
    
    public static let shared = UserManager()
    private init(){}
    
    
    // check if user is logged in
    func isUserLoggedIn()-> Bool{
        return getAuthorizationToken() != nil ? true : false
    }
    
    //UserInfo
    func setUserData(user: User){
        UserDefaults.standard.set(user.token, forKey: "USERTOKEN")
        UserDefaults.standard.set(user.userId, forKey: "UserId")
    }
    
    func getUserId() -> Int?{
        return UserDefaults.standard.integer(forKey: "UserId")
    }
    
    func getAuthorizationToken() -> String?{
        return UserDefaults.standard.string(forKey: "USERTOKEN")
    }
    
    func clearData(){
        UserDefaults.standard.removeObject(forKey: "USER")
        UserDefaults.standard.removeObject(forKey: "USERTOKEN")
        UserDefaults.standard.removeObject(forKey: "UserId")
    }
}
