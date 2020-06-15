//
//  NetworkManager.swift
//  DVAPIManager
//
//  Created by Vaibhav Jain on 02/09/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

public struct NetworkManager {
    static  let dvServiceRouter = DVRouter<DVAuthApi>()
    static func generateToken(completion: @escaping (Result<DVAuthTokenResponse?, APIError>) -> Void) {
        dvServiceRouter.fetch(.generateToken, decode: { json -> DVAuthTokenResponse? in
            guard let result = json as? DVAuthTokenResponse else { return  nil }
            return result
        }, completion: completion)
    }
    
    static func refreshToken(completion: @escaping (Result<DVAuthTokenResponse?, APIError>) -> Void) {
        dvServiceRouter.fetch(.refreshToken, decode: { json -> DVAuthTokenResponse? in
            guard let result = json as? DVAuthTokenResponse else { return  nil }
            return result
        }, completion: completion)
    }
    
    public static func clearToken() {
       UserDefaults.standard.setValue(nil, forKey: "DVAuthApi_clientID")
        UserDefaults.standard.setValue(nil, forKey: "DVAuthApi_clientSecret")
        UserDefaults.standard.set(nil, forKey: "AccessToken")
    }
}


extension NetworkManager: EndpointManager {
    public static func setApiConfig(config: ApiConfig) {
        NetworkManager.baseURL = config.baseURL
        NetworkManager.timeout = config.timeout
        NetworkManager.isAuthorization = config.isAuthorization
        NetworkManager.clientID = config.clientID
        NetworkManager.clientSecret = config.clientSecret
        NetworkManager.authGrantType = config.authType
        if config.authType == .passwordGrant {
            UserDefaults.standard.set(clientID, forKey: "AccessToken")
        }
    }
    
    static var baseURL: String {
        get {
            return UserDefaults.standard.string(forKey: "DVAuthApi_BaseURL") ?? ""
        }
        set(urlStr) {
            UserDefaults.standard.setValue(urlStr, forKey: "DVAuthApi_BaseURL")
        }
    }
    
    static var clientID: String? {
        get {
            return UserDefaults.standard.string(forKey: "DVAuthApi_clientID")
        }
        set(clientID) {
            UserDefaults.standard.setValue(clientID, forKey: "DVAuthApi_clientID")
        }
    }
    
    static var clientSecret: String? {
        get {
            return UserDefaults.standard.string(forKey: "DVAuthApi_clientSecret")
        }
        set(secret) {
            UserDefaults.standard.setValue(secret, forKey: "DVAuthApi_clientSecret")
        }
    }
    
    static var timeout: TimeInterval {
        get {
            let timeoutConfig = UserDefaults.standard.double(forKey: "DVAuthApi_Timeout")
            if timeoutConfig == 0 {
                return 60.0
            }
            return timeoutConfig
        }
        set(timeoutConfig) {
            UserDefaults.standard.setValue(timeoutConfig, forKey: "DVAuthApi_Timeout")
        }
    }
    
    static var isAuthorization: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "DVAuthApi_Authorization")
        }
        set(isAuthorized) {
            UserDefaults.standard.setValue(isAuthorized, forKey: "DVAuthApi_Authorization")
        }
    }
    
    static var authGrantType: AuthGrantTypes {
        get {
            let authType = UserDefaults.standard.integer(forKey: "DVAuthApi_AuthGrantType")
            return AuthGrantTypes(rawValue: authType) ?? AuthGrantTypes.clientCredentials
        }
        set(authType) {
            UserDefaults.standard.set(authType.rawValue, forKey: "DVAuthApi_AuthGrantType")
        }
    }
}
