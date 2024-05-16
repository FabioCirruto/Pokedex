//
//  EndPoint.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation
import Alamofire
enum APIMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum EndPoint {
    case List(Int, Int)
    case Detail(String)
    case Desc(String)
    case Search(String)
}

extension EndPoint: URLRequestConvertible {
    var basePath: String {
        switch self {
        case .Detail(let url), .Desc(let url):
            return url
        case .Search(let text):
            return Enviroment.apiUrl + text
        default:
            return Enviroment.apiUrl
        }
    }
    
    var method: String {
        switch self {
        case .List, .Detail(_), .Desc(_), .Search(_):
            APIMethod.get.rawValue
        }
    }
    
    var urlParameters: [String : Any]? {
        switch self {
        case .List(let limit, let offset):
            return [
                "limit": limit,
                "offset": offset
            ]
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: basePath)!)
        urlRequest.httpMethod = method
        
        if let urlParameters = urlParameters {
            if let url = urlRequest.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                components.queryItems = [URLQueryItem]()
                
                for (key, value) in urlParameters {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    components.queryItems?.append(queryItem)
                }
                
                urlRequest.url = components.url
            }
        }
        
        return urlRequest
    }
}
