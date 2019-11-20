//
//  CharacterDataModel.swift
//  Marvel
//
//  Created by Magy Elias on 8/7/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation

struct CharacterDataModel: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [CharacterModel]?
    
    private enum CodingKeys: String, CodingKey {
        case offset, limit, total, count, results
    }
}
