//
//  Fonts.swift
//  DesignSystem
//
//  Created by Bodgar Espinosa Miranda on 16/12/24.
//

import Foundation
import UIKit

public enum Fonts {
    /// Size 22 - Bold - Linear spacing 22/31
    case H1
    /// Size 18 - Bold - Linear spacing 18/23
    case H2
    /// Size 16 - Bold - Linear spacing 16/26
    case H3
    /// Size 16 - Semibold - Linear spacing 16/26
    case H4
    /// Size 14 - Semibold - Linear spacing 14/22
    case H5
    /// Size 16 - Regular - Linear spacing 16/26
    case T1
    /// Size 14 - Regular - Linear spacing 14/22
    case T2
    /// Size 12 - Regular - Linear spacing 12/19
    case info
    /// Size 11 - Medium - Linear spacing 11/14
    case menuActive
    /// Size 11 - Regular - Linear spacing 11/14
    case menuDefault
    
    public var attributes: (font: UIFont, lineSpacing: CGFloat) {
        switch self {
        case .H1:
            return (.boldSystemFont(ofSize: 22), 31 - 22)
        case .H2:
            return (.boldSystemFont(ofSize: 18), 23 - 18)
        case .H3:
            return (.boldSystemFont(ofSize: 16), 26 - 16)
        case .H4:
            return (.systemFont(ofSize: 16, weight: .semibold), 26 - 16)
        case .H5:
            return (.systemFont(ofSize: 14, weight: .semibold), 22 - 14)
        case .T1:
            return (.systemFont(ofSize: 16, weight: .regular), 26 - 16)
        case .T2:
            return (.systemFont(ofSize: 14, weight: .regular), 22 - 14)
        case .info:
            return (.systemFont(ofSize: 12, weight: .regular), 19 - 12)
        case .menuActive:
            return (.systemFont(ofSize: 11, weight: .medium), 14 - 11)
        case .menuDefault:
            return (.systemFont(ofSize: 11, weight: .regular), 14 - 11)
        }
    }
}
