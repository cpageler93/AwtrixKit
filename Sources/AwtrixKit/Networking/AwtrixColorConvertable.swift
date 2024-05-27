//
//  AwtrixColorConvertable.swift
//  AwtrixKit
//
//  Created by Christoph Pageler on 25.05.24.
//

import Foundation

public protocol AwtrixColorConvertable {
    var awtrixColorCode: String { get }
}

extension String: AwtrixColorConvertable {
    public var awtrixColorCode: String {
        var result = self
        if !hasPrefix("#") { result = "#\(result)" }
        return result
    }
}

#if canImport(UIKit)
import UIKit
extension UIColor: AwtrixColorConvertable {
    public var awtrixColorCode: String {
        if self == UIColor.clear {
            return "0"
        } else {
            return hexCode.awtrixColorCode
        }
    }
}
#endif

