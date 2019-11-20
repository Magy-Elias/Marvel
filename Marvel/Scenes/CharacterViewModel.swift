//
//  CharacterViewModel.swift
//  Marvel
//
//  Created by Magy Elias on 8/8/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation

struct CharacterViewModel: Codable {
    let id: Double?
    let name: String?
    let description: String?
    let image: String?
    
    init(characterModel: CharacterModel) {
        self.id = characterModel.id
        self.name = characterModel.name
        self.description = characterModel.description
        self.image = characterModel.thumbnail?.fullPath ?? nil
    }
}
