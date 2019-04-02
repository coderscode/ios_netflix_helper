//
//  Router.swift
//
//  Created by Prakash Kotwal on 1/28/18.
//


import UIKit
import Alamofire

let AuthenticationString    =   ""

enum Router: URLRequestConvertible {
    static let baseAPIURLString = ""
    
    case getGreetings()
    
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .getGreetings:
                return .get
                
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .getGreetings:
                return nil
                
            }
        }()
        
        let url: URL = {
            return URL(string: "http://13.232.178.62/api/greeting/home/")
        }()!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
//        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("fdd097b8-1125-4d15-86cc-63ef0dfc4bc5", forHTTPHeaderField: "Authorization")
        
        
        let encoding = URLEncoding()
        return try encoding.encode(urlRequest, with: params)
    }
}


