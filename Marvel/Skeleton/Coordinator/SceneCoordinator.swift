//
//  SceneCoordinator.swift
//  Marvel
//
//  Created by Magy Elias on 8/6/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import UIKit

/**
 Scene coordinator, manage scene navigation and presentation.
 */

class SceneCoordinator: NSObject, SceneCoordinatorType {
    
    static var shared: SceneCoordinator!
    
    fileprivate var window: UIWindow
    fileprivate var currentViewController: UIViewController? {
        didSet {
            currentViewController?.navigationController?.delegate = self
        }
    }
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        
        if let navigationController = viewController as? BaseNavigationController {
            return navigationController.viewControllers.first!
        }
        return viewController
    }
    
    func transition(to scene: TargetScene, onComplete: @escaping (() -> Void)) {
        switch scene.transition {
        case let .root(viewController):
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            window.rootViewController = viewController
            onComplete()
        case let .push(viewController):
            guard let currentViewController = currentViewController, let navigationController = currentViewController.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
            navigationController.pushViewController(SceneCoordinator.actualViewController(for: viewController), animated: true)
        }
    }
    
    func pop(animated: Bool, onComplete: @escaping (() -> Void)) {
        if let navigationController = currentViewController?.navigationController {
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(currentViewController)")
            }
            currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
            navigationController.popViewController(animated: true)
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension SceneCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}
