//
//  UIColor+.swift
//  UniqueDictionary
//
//  Created by 加藤祥真 on 2022/07/04.
//

import UIKit

extension UIColor {

    // 以下で拡張色の定義
    static let pastelRed = UIColor(hex: "#FF9999")

    static let lightBlack = UIColor(hex: "#323232")

    //  色をhexで編集できるように修正
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        let validatedHexColorCode = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: validatedHexColorCode)
        var colorCode: UInt64 = 0

        guard scanner.scanHexInt64(&colorCode) else {
            print("ERROR: 色変換に失敗しました。")
            return nil
        }

        let R = CGFloat((colorCode & 0xFF0000) >> 16) / 255.0
        let G = CGFloat((colorCode & 0x00FF00) >> 8) / 255.0
        let B = CGFloat(colorCode & 0x0000FF) / 255.0
        self.init(displayP3Red: R, green: G, blue: B, alpha: alpha)
    }
}
