//
//  UIColor+Hex.swift
//  AwtrixKit
//
//  Created by Christoph Pageler on 25.05.24.
//

import Foundation
#if canImport(UIKit)
import UIKit

internal extension UIColor {
    var hexCode: String {
        let r: CGFloat = cgColor.components?[0] ?? 0.0
        let g: CGFloat = cgColor.components?[1] ?? 0.0
        let b: CGFloat = cgColor.components?[2] ?? 0.0

        return String.init(
            format: "%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
     }
}
#endif
