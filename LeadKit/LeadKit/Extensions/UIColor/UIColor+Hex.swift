//
//  UIColor+Hex.swift
//  LeadKit
//
//  Created by Ivan Smolin on 07/09/16.
//  Copyright © 2016 Touch Instinct. All rights reserved.
//

import UIKit

public extension UIColor {

    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.

     - parameter hex3:  Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.

     - returns: new instance with given three-digit hexadecimal value
     */
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let red     = CGFloat((hex3 & 0xF00) >> 8) / 0xFF
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / 0xFF
        let blue    = CGFloat((hex3 & 0x00F) >> 0) / 0xFF
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.

     - parameter hex4: Four-digit hexadecimal value.

     - returns: new instance with given four-digit hexadecimal value
     */
    public convenience init(hex4: UInt16) {
        let red     = CGFloat((hex4 & 0xF000) >> 12) / 0xFF
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / 0xFF
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / 0xFF
        let alpha   = CGFloat((hex4 & 0x000F) >>  0) / 0xFF

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.

     - parameter hex6:  Six-digit hexadecimal value.
     - parameter alpha: alpha: 0.0 - 1.0. The default is 1.0.

     - returns: new instance with given six-digit hexadecimal value
     */
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / 0xFF
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / 0xFF
        let blue    = CGFloat((hex6 & 0x0000FF) >>  0) / 0xFF

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.

     - parameter hex8: Eight-digit hexadecimal value.

     - returns: new instance with given eight-digit hexadecimal value
     */
    public convenience init(hex8: UInt32) {
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / 0xFF
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / 0xFF
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / 0xFF
        let alpha   = CGFloat((hex8 & 0x000000FF) >>  0) / 0xFF

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }


    /**
     convenience failable initializer which creates an instance with given hex color values if string has a correct format

     - parameter hexString: hex string with red green and blue values (can have `#` sign)
     - parameter alpha: alpha component used if not given in hexString

     - returns: new instance with given hex color or nil if hexString is incorrect
     */
    public convenience init?(hexString: String, alpha: CGFloat = 1) {
        let hexStr = hexString.hasPrefix("#") ? hexString.substringFromIndex(hexString.startIndex.advancedBy(1)) : hexString

        switch hexStr.characters.count {
        case 3:
            if let hex = UInt16(hexStr, radix: 16) {
                self.init(hex3: hex, alpha: alpha)
            }
        case 4:
            if let hex = UInt16(hexStr, radix: 16) {
                self.init(hex4: hex)
            }
        case 6:
            if let hex = UInt32(hexStr, radix: 16) {
                self.init(hex6: hex, alpha: alpha)
            }
        case 8:
            if let hex = UInt32(hexStr, radix: 16) {
                self.init(hex8: hex)
            }
        default:
            return nil
        }

        return nil
    }

}
