//
//  CharacterPresenter.swift
//  Marvel
//
//  Created by Magy Elias on 8/8/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

protocol CharacterPresentationLogic: class {
    func getCharacterDetail()
}

final class CharacterPresenter: BasePresenter, CharacterPresentationLogic {
    
    func getCharacterDetail() {
        
    }
//        (pageNumber: Int, showHideActivityIndicator: Bool, onComplete: @escaping ((Int, [CharacterViewModel]) -> Void)) {
//        if showHideActivityIndicator { showActivityIndicator() }
//
//        let requestOnComplete: (MarvelAPIsResult<CharactersResultModel>) -> Void = { [weak self] result in
//            if showHideActivityIndicator { self?.dismissActivityIndicator() }
//
//            switch result {
//            case .success(let model):
//                guard let totalCount = model.data?.total,
//                    let character = model.data?.results else { return }
//                onComplete(totalCount, character.map(CharacterViewModel.init))
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//        startRequest(api: .characters, onComplete: requestOnComplete)
//    }
    
    // Navigation
    
    func navigateBack() {
        //        SceneCoordinator.shared.transition(to: Scene.characterDetail, onComplete: {
        //        })
    }
}
