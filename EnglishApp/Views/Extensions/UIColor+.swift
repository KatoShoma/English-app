//
//  UIColor+.swift
//  UniqueDictionary
//
//  Created by 加藤祥真 on 2022/07/04.
//

import UIKit

extension UIColor {

    // 以下で拡張色の定義
    // 黒
    static let lightBlack = UIColor(hex: "#323232")
    // 赤
    static let pastelRed = UIColor(hex: "#FF9999")
    // 背景(白)
    static let backGround = UIColor(hex: "#FFFFFF")
    // 画面下部の白みの強いグレー
    static let lightGray = UIColor(hex: "#F5F4F4")
    // 調理開始
    static let startOrange = UIColor(hex: "#DF7756")
    // 時間の設定
    static let timerBlue = UIColor(hex: "#ACCDFF")
    // タイトルに戻る
    static let returnGray = UIColor(hex: "#C4C4C4")
    // ドラムピッカー・苦手単語・学習回数・最高正答数
    static let timerGray = UIColor(hex: "#D9D9D9")
    // ランクボタン
    static let rankCream = UIColor(hex: "#FFEAD1")
    // 保存・キャンセルボタン・ランクとは
    static let lightBlue = UIColor(hex: "#0AC4FF")
    // ゴールド
    static let gold = UIColor(hex: "#BFAB40")
    // シルバー
    static let silver = UIColor(hex: "#7C7979")
    // ブロンズ
    static let bronze = UIColor(hex: "#DF7756")
    // 設定
    static let settingPink = UIColor(hex: "#FFF4F9")

    // 色をhexで編集できるように修正
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
