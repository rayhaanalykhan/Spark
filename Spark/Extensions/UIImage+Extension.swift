//
//  UIImage+Extension.swift
//  Spark
//
//  Created by rayhaanalykhan on 26/06/2024.
//

import UIKit

// MARK: - UIImage initializer to initialize custom icons/system icons using enum.
extension UIImage {
    
    convenience init?(named: Icon) {
        self.init(named: named.rawValue)
    }
    
    enum Icon: String {
        
        case crossCircle = "CrossCircle"
        case tickCircle = "TickCircle"
        case dropDownArrow = "DropDownArrow"
        case gear = "Gear"
        case magnifierGlass = "MagnifierGlass"
        case splash = "Splash"
    }
}
