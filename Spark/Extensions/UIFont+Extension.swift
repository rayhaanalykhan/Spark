//
//  UIFont+Extension.swift
//  Spark
//
//  Created by rayhaanalykhan on 26/06/2024.
//

import UIKit

// MARK: - UIFont initializer to initialize custom fonts using enum.
extension UIFont {
    
    convenience init?(inter: Inter, size: CGFloat) {
        self.init(name: inter.rawValue, size: size)
    }
    convenience init?(inter: Inter, style: UIFont.TextStyle) {
        self.init(name: inter.rawValue, size: UIFont.preferredFont(forTextStyle: style).pointSize)
    }
    
    enum Inter: String {
        case black = "Inter-Black"
        case bold = "Inter-Bold"
        case extraBold = "Inter-ExtraBold"
        case extraLight = "Inter-ExtraLight"
        case light = "Inter-Light"
        case medium = "Inter-Medium"
        case regular = "Inter-Regular"
        case semiBold = "Inter-SemiBold"
        case thin = "Inter-Thin"
    }
}
