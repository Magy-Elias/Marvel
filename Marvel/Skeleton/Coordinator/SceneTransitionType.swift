//
//  SceneTransitionType.swift
//  Marvel
//
//  Created by Magy Elias on 8/6/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import UIKit

enum SceneTransitionType {
    
    case root(UIViewController)       // make view controller the root view controller.
    case push(UIViewController)       // push view controller to navigation stack.
}
