//
//  TabBarController+.swift
//  UniqueDictionary
//
//  Created by 加藤祥真 on 2022/07/04.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textColor: UIColor = UIColor.lightBlack! // 文字色の指定
        let backgroundColor: UIColor = UIColor.white // 背景色の指定
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = backgroundColor
        UITabBar.appearance().tintColor = textColor
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    
}
