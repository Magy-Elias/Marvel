//
//  CharactersListViewModel.swift
//  Marvel
//
//  Created by Magy Elias on 8/6/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation

struct CharacterViewModel {
    let id: Double?
    let name: String?
    let description: String?
//    let image: ImageModel
    
    init(charactersModel: CharacterModel) {
        self.id = charactersModel.id
        self.name = charactersModel.name
        self.description = charactersModel.description
    }
}
