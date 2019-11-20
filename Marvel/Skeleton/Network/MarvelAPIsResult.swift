//
//  MarvelAPIsResult.swift
//  Marvel
//
//  Created by Magy Elias on 8/7/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation

enum MarvelAPIsResult<ResponseModel: Codable>{
    case success(ResponseModel)
    case failure(Error)
}
