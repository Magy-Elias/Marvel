//
//  CharactersResultModel.swift
//  Marvel
//
//  Created by Magy Elias on 8/7/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation

struct CharactersResultModel: Codable {
    let code: Int?
    let status: String?
    let data: CharacterDataModel?
    
    private enum CodingKeys: String, CodingKey {
        case code, status, data
    }
}
