//
//  ServerConfiguration.swift
//  Spark
//
//  Created by rayhaanalykhan on 27/06/2024.
//

import Foundation

enum ServerConfiguration {
    
    case dev
    case test
    case live
    
    private static var currentBaseURL: ServerConfiguration = .dev
    
    static var baseURL: String {
        
        switch currentBaseURL {
            
        case .dev: return "https://api.mockfly.dev/mocks/"
        case .test: return "some test url"
        case .live: return "some live url"
            
        }
    }
}

