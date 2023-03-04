//
//  SAGAA.swift
//  SAGAA
//
//  Created by Monica Girgis Kamel on 24/03/2022.
//

import Foundation
//import Alamofire

enum SAGAA{
    // MARK: - login
    case login(username: String, password: String)
    
    
}

extension Bundle {
    var baseURL: String {
        return object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }
    
    var urlSubFolder: String {
        return object(forInfoDictionaryKey: "URLSubFolder") as? String ?? ""
    }
}

extension SAGAA: Endpoint{
    var base: String {
        return Bundle.main.baseURL
    }
    
    var urlSubFolder: String {
        return Bundle.main.urlSubFolder
    }
    
    var path: String {
        switch self {
        case .login:
            return "Account/Token"
        
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        switch self{
       
        default:
            return queryItems
        }
        
    }
    
    var body: [String: Any]?{
        var params: [String: Any] = [:]
        
        switch self{
        case .login(let username, let password):
            params["username"] = username
            params["password"] = password
            return params
            
        default:
            return nil
        }
    }
    
    var headers : [httpHeader] {
        var headers: [httpHeader] = []
//        headers.append(httpHeader(key: "lang", value: (Language.getCurrentLanguage() == "ar") ? "ar" : "en"))
        
        if let token = UserManager.shared.getAuthorizationToken(), !token.isEmpty {
            headers.append(httpHeader(key: "Authorization", value: "Bearer " + token))
        }
        return headers
    }
}

extension URLRequest{
    mutating func addHeaders(_ Headers:[httpHeader]){
        for Header in Headers {
            self.addValue(Header.value, forHTTPHeaderField: Header.key)
        }
    }
}
