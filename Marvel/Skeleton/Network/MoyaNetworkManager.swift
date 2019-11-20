//
//  MoyaNetworkManager.swift
//  Marvel
//
//  Created by Magy Elias on 8/7/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation
import Moya

class MoyaNetworkManager: Repository {
    
    lazy var plugins: [PluginType] = {
        return [NetworkLoggerPlugin(verbose: true)]
    }()
    
    private lazy var provider: MoyaProvider<MarvelAPIs> = {
        return MoyaProvider<MarvelAPIs>(plugins: plugins)
    }()
    
    init() { }
    
    func startRequest<T: Codable>(api: MarvelAPIs, onComplete: @escaping (MarvelAPIsResult<T>) -> Void) {
        
        provider.request(api) { result in
            switch result {
            case .success(let response):
                do {
                    let responseModel: T = try JSONDecoder().decode(T.self, from: response.data)
                    
                    onComplete(.success(responseModel))
                } catch let error {
                    // Parsing error here
                    onComplete(.failure(error))
                }
                
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
