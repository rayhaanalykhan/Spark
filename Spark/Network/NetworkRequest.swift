//
//  NetworkRequest.swift
//  Spark
//
//  Created by rayhaanalykhan on 27/06/2024.
//

import Moya
import UIKit

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {}
}

extension NetworkRequest {
    
    func request<T: Decodable>(target: APIClient, completion: @escaping (Result<T, Error>) -> ()) -> Cancellable {
        
        let provider =  MoyaProvider<APIClient>(plugins: [VerbosePlugin(verbose: true)])
        
        let cancellable = provider.request(target) { result in
            
            switch result {
                
            case let .success(response):
                
                
                if response.statusCode == 500 { // handle internal server error here
                    
                    print("Internal Server Error")
                    
                    return
                }
                
                if response.statusCode == 401 && target.authorizationType == .bearer {
                    
                    print("Session Expired")
                    
                    return
                }
                
                // For the purpose of this test, i am skipping proper handling (with alerts/toast) of other above response code (500 and 401).

                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    
                    completion(.success(results))
                    
                } catch let error as NSError {
                    
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                    
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return cancellable
    }
}

private struct VerbosePlugin: PluginType {
    
    let verbose: Bool
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
#if DEBUG
        if
            let body = request.httpBody,
            let dataAsJson = try? JSONSerialization.jsonObject(with: body),
            let prettyData = try? JSONSerialization.data(withJSONObject: dataAsJson, options: .prettyPrinted),
            let str = String(data: prettyData, encoding: .utf8)
        {
            if verbose {
                print("Request Parameters:")
                print(str)
            }
        }
#endif
        return request
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
#if DEBUG
        switch result {
            
        case .success(let body):
            
            if verbose {
                
                print("Response:")
                
                if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers) {
                    
                    print(json)
                    
                } else {
                    
                    let response = String(data: body.data, encoding: .utf8)!
                    print(response)
                }
                
//                print(String(repeating: "-", count: 60))
            }
        case .failure( _):
            break
        }
#endif
    }
}
