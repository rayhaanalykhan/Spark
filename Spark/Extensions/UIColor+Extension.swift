//
//  UIColor+Extension.swift
//  Spark
//
//  Created by rayhaanalykhan on 26/06/2024.
//

import UIKit

// MARK: - UIColor initializer to initialize custom colors using enum.
extension UIColor {
    
    convenience init?(color: CustomColor) {
        self.init(named: color.rawValue)
    }
    
    enum CustomColor: String {
        case contactListBG = "ContactListBG"
        case searchBGDisabled = "SearchBGDisabled"
        case searchBGEnabled = "SearchBGEnabled"
    }
}

