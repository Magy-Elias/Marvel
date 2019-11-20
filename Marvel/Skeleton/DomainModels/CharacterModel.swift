//
//  CharacterModel.swift
//  Marvel
//
//  Created by Magy Elias on 8/7/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation

struct CharacterModel: Codable {
    let id: Double?
    let name: String?
    let description: String?
    let thumbnail: ImageModel?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, thumbnail
    }
}
