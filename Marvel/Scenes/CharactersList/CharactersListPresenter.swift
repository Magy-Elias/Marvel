//
//  CharactersListPresenter.swift
//  Marvel
//
//  Created by Magy Elias on 8/6/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

protocol CharactersListPresentationLogic: class {
    func getCharacters(pageNumber: Int, showHideActivityIndicator: Bool, onComplete: @escaping ((Int, [CharacterViewModel]) -> Void))
    func getFilteredCharacters(with characterName: String, showHideActivityIndicator: Bool, onComplete: @escaping ((Int, [CharacterViewModel]) -> Void))
    func navigateToCharacterDetail(character: CharacterViewModel)
}

final class CharactersListPresenter: BasePresenter, CharactersListPresentationLogic {

    func getCharacters(pageNumber: Int, showHideActivityIndicator: Bool, onComplete: @escaping ((Int, [CharacterViewModel]) -> Void)) {
        if showHideActivityIndicator { showActivityIndicator() }
        
        let requestOnComplete: (MarvelAPIsResult<CharactersResultModel>) -> Void = { [weak self] result in
            if showHideActivityIndicator { self?.dismissActivityIndicator() }
            
            switch result {
            case .success(let model):
                guard let totalCount = model.data?.total,
                let character = model.data?.results else { return }
                onComplete(totalCount, character.map(CharacterViewModel.init))
                
            case .failure(let error):
                print(error)
            }
        }
        startRequest(api: .characters(characterName: nil, offset: pageNumber), onComplete: requestOnComplete)
    }
    
    func getFilteredCharacters(with characterName: String, showHideActivityIndicator: Bool, onComplete: @escaping ((Int, [CharacterViewModel]) -> Void)) {
        if showHideActivityIndicator { showActivityIndicator() }
        
        let requestOnComplete: (MarvelAPIsResult<CharactersResultModel>) -> Void = { [weak self] result in
            if showHideActivityIndicator { self?.dismissActivityIndicator() }
            
            switch result {
            case .success(let model):
                guard let totalCount = model.data?.total,
                    let character = model.data?.results else { return }
                onComplete(totalCount, character.map(CharacterViewModel.init))
                
            case .failure(let error):
                print(error)
            }
        }
        startRequest(api: .characters(characterName: characterName, offset: nil), onComplete: requestOnComplete)
    }
    
    // Navigation
    
    func navigateToCharacterDetail(character: CharacterViewModel) {
        SceneCoordinator.shared.transition(to: Scene.characterDetails(characterDetails: character), onComplete: {
        })
    }
}
