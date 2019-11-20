//
//  ImageModel.swift
//  Marvel
//
//  Created by Magy Elias on 8/7/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation

struct ImageModel: Codable {
    private let path: String?
    private let fileExtension: String?
    
    var fullPath: String? {
        guard let path = path, let fileExtension = fileExtension else { return nil }
        let securePath = path.replacingOccurrences(of: "http", with: "https")
        return "\(securePath).\(fileExtension)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }
}
