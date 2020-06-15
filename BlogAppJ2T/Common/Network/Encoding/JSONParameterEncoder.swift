//
//  JSONParameterEncoder.swift
//  DVAPIManager
//
//  Created by Vaibhav Jain on 02/09/20.
//  Copyright © 2019 DigiValet. All rights reserved.
//

import Foundation
public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters, documents: [Document]? = nil) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/vnd.digivalet.v1+json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
