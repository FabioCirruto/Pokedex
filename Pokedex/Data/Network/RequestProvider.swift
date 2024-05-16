//
//  RequestProvider.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 14/05/24.
//

import Foundation
import Alamofire

enum ApiError: Error {
    case NoData
}

class RequestProvider {
    private let session: Session
    static let shared = RequestProvider()
    
    init() {
        session = .default
    }
    
    func request<T: Codable>(source: EndPoint, of type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            session.request(source).response { response in
                switch response.result {
                case .success(let value):
                    guard let data = value else {
                        continuation.resume(throwing: ApiError.NoData)
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(T.self, from: data)
                        continuation.resume(returning: decoded)
                    } catch let error {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
