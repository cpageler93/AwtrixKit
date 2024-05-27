//
//  AwtrixIndicator.swift
//  AwtrixKit
//
//  Created by Christoph Pageler on 25.05.24.
//

import Foundation

public enum IndicatorPosition {
    case topRight
    case right
    case bottomRight

    internal var path: String {
        switch self {
        case .topRight:
            return "indicator1"
        case .right:
            return "indicator2"
        case .bottomRight:
            return "indicator3"
        }
    }
}
