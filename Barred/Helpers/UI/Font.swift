//
//  Font.swift
//  Barred
//
//  Created by RCD on 24/05/2023.
//

import Foundation
import UIKit

extension UIFont {

    public enum CustomType: String {
        
        case regular = "-Regular"
        case light = "-Light"
        case extraBold = "-Extrabold"
        case bold = "-Bold"
    }

    static func CustomFont(_ type: CustomType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        
        guard let almarai = UIFont(name: "Almarai\(type.rawValue)", size: size + 1.0),
                      let poppins = UIFont(name: "Poppins\(type.rawValue)", size: size) else {
                    return .systemFont(ofSize: size)
                }

                let poppinsFontWithCustomAlmaraiFallback = poppins.fontDescriptor.addingAttributes(
                    [.cascadeList: [almarai.fontDescriptor]]
                )

                return UIFont(descriptor: poppinsFontWithCustomAlmaraiFallback, size: size)
    }
    
    public enum FontSize: CGFloat {
        
        case footnote
        
        public var rawValue: CGFloat {
            
            switch self {
                
            case .footnote: return UIScreen.main.bounds.size.width * 0.03
                
            }
        }
    }
}
