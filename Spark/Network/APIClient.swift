//
//  APIClient.swift
//  Spark
//
//  Created by rayhaanalykhan on 27/06/2024.
//

import Moya
import Foundation

enum APIClient {
    
    // Roster
    case getRosterWithContactList
    
}

extension APIClient: TargetType, AccessTokenAuthorizable {
    
    var baseURL: URL {
        guard let url = URL(string: ServerConfiguration.baseURL) else { fatalError() }
        return url
    }
    
    var path: String {
        
        switch self {
            
            // Roster
        case .getRosterWithContactList:
            return "1f7f7b81-4043-4b86-bb26-7671dc92434d/contacts"

        }
    }
    
    var task: Task {
        
        switch self {
            
            // Roster
        case .getRosterWithContactList:
            return .requestPlain
            
        }
    }
    
    var method: Moya.Method {
        
        switch self {
            
        default:
            return .get // since there is only 1 'get' api we are using default case as 'get'
        }
    }
    
    var authorizationType: AuthorizationType? {
        
        switch self {
            
        default:
            return .none // since there is only 1 api with not bearer token requirement we are using default case as none
        }
    }
    
    var headers: [String : String]? {
        
        switch authorizationType {
            
        case .none:
            return nil
            
        default:
    
            return [
                "Authorization": "Bearer some bearer token", 
            ]
        }
    }
}
