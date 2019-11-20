//
//  Marvel.swift
//  Marvel
//
//  Created by Magy Elias on 8/7/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation
import Moya
import CryptoSwift

fileprivate struct MarvelAPIsConfig {
    static let privateKey = "f1793931f389936d3955a61dc420b123bab684e4"
    static let publicKey = "2fa224aed906548f5dd78f02a92c67cc"
    static let ts = Date().timeIntervalSince1970.description
    static let hash = "\(ts)\(MarvelAPIsConfig.privateKey)\(MarvelAPIsConfig.publicKey)".md5()
}


enum MarvelAPIs {
    case characters(characterName: String?, offset: Int?)
    case image
}

extension MarvelAPIs: TargetType {
    // 1
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com")!
    }
    
    // 2
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .image:
            return "/v1/public/comics/series/stories/events"
        }
    }
    
    // 3
    var method: Moya.Method {
        switch self {
        case .characters, .image:
            return .get
        }
    }
    
    // 4
    var sampleData: Data {
        switch self {
        case .characters:
            return readJsonFile("CharactersMockFile")
        case .image:
            return readJsonFile("ImageMockFile")
        }
    }
    
    // 5
    var parameters: [String: Any] {
        
        var parameters: [String: Any] = ["apikey": MarvelAPIsConfig.publicKey,
                          "ts": MarvelAPIsConfig.ts,
                          "hash": MarvelAPIsConfig.hash]
        
        switch self {
        case .characters(let characterName, let offset):
            if let characterName = characterName {
                parameters["name"] = characterName
            }
            
            if let offset = offset {
                parameters["offset"] = offset
            }
        default:
            break
        }
        
        return parameters
    }
    
    // 6
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    // 7
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    // 8
    var validationType: ValidationType {
        return .successCodes
    }
    
    // 9
    private func readJsonFile(_ filename: String) -> Data! {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }
}
