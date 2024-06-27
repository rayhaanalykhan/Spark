//
//  BaseDM.swift
//  Spark
//
//  Created by rayhaanalykhan on 25/06/2024.
//

import Foundation

struct BaseDM<ResponseData: Codable> : Codable {
    
    var message: String?
    var result: ResponseData?
    var hasErrors: Bool?
    var error: String?
    var timestamp: String?
}
