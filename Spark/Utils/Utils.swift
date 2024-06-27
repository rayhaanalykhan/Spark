//
//  Utils.swift
//  Spark
//
//  Created by rayhaanalykhan on 27/06/2024.
//

import Foundation

class Utils {
    
    static let shared = Utils()
    
    private init() {}
}

extension Utils {
    
    func convertToAMPMTimeFormat(dateString: String?) -> String {
        
        guard let dateString else {
            return "Some time"
        }
        
        // Define the date formats
        let formats = [
            "M/d/yyyy h:mm a", // Format for "7/7/2023 11:00 AM"
            "yyyy-MM-dd'T'HH:mm:ss" // Format for "2023-07-07T07:00:00"
        ]
        
        let dateFormatter = DateFormatter()
        
        for format in formats {
            
            dateFormatter.dateFormat = format
            
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: date)
            }
        }
        return dateString
    }
}
