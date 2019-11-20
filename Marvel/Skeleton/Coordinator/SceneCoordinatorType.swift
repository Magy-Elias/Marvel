//
//  SceneCoordinatorType.swift
//  Marvel
//
//  Created by Magy Elias on 8/6/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import UIKit

protocol SceneCoordinatorType {
    init(window: UIWindow)
    
    func transition(to scene: TargetScene, onComplete: @escaping (() -> Void))
    func pop(animated: Bool, onComplete: @escaping (() -> Void))
}

