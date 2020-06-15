//
//  EndPointType.swift
//  DVAPIManager
//
//  Created by Vaibhav Jain on 02/09/20.
//  Copyright © 2019 DigiValet. All rights reserved.
//

import Foundation
public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var timeout: TimeInterval { get }
    var isAuthorization: Bool { get }
}
