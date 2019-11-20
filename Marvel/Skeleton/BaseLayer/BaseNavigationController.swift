//
//  BaseNavigationController.swift
//  Marvel
//
//  Created by Magy Elias on 8/6/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = ColorConstants.white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorConstants.white]
        navigationBar.barTintColor = .red
        
//        navigationBar.tintColor = .red
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
    }
}
