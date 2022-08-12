//
//  NavigationBarController.swift
//  UniqueDictionary
//
//  Created by 加藤祥真 on 2022/07/05.
//

import Foundation
import UIKit

class NavigationBarController {
    
    static func customNavigationBar() {
        
        let textColor: UIColor = UIColor.lightBlack! // 文字色の指定
        let backgroundColor: UIColor = UIColor.white // 背景色の指定
        
        // 全てのNavigation Barの色を変更する
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = backgroundColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
    }
}
