//
//  Scene.swift
//  Marvel
//
//  Created by Magy Elias on 8/6/19.
//  Copyright © 2019 Magy Elias. All rights reserved.

import UIKit

/**
 Refers to a screen managed by a view controller.
 It can be a regular screen, or a modal dialog.
 It comprises a view controller and a view model.
 */

protocol TargetScene {
    var transition: SceneTransitionType { get }
}

enum Scene {
    case charactersList
    case characterDetails(characterDetails: CharacterViewModel)
}

extension Scene: TargetScene {
    var transition: SceneTransitionType {
        switch self {
        case .charactersList:
            let charactersListPresenter = CharactersListPresenter()
            let charactersListStoryboard = UIStoryboard(storyboard: .CharactersList)
            let charactersListVC: CharactersListViewController = charactersListStoryboard.instantiateViewController()
            charactersListVC.charactersListPresenter = charactersListPresenter
            
            let rootBaseNavigationC = BaseNavigationController(rootViewController: charactersListVC)
            return .root(rootBaseNavigationC)
            
        case .characterDetails(let characterDetails):
            let characterPresenter = CharacterPresenter()
            let characterStoryboard = UIStoryboard(storyboard: .Character)
            let characterVC: CharacterViewController = characterStoryboard.instantiateViewController()
            characterVC.characterPresenter = characterPresenter
            characterVC.characterDetails = characterDetails
            return .push(characterVC)
        }
    }
}
