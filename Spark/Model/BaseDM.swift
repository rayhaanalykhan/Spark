//
//  BaseDM.swift
//  Spark
//
//  Created by rayhaanalykhan on 25/06/2024.
//

import Foundation

struct BaseDM<ResponseData: Codable> : Codable {
    
    let message: String?
    let result: ResponseData?
    let hasErrors: Bool?
    let error: String?
     
    let timestamp: String? // this key should return inside the 'result' object
}
