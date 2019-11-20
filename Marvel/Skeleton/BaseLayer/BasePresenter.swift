//
//  BasePresenter.swift
//  Marvel
//
//  Created by Magy Elias on 8/7/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation

class BasePresenter {
    
    lazy var activityIndicator = NVActivityIndicator()
    lazy var repository = MoyaNetworkManager()
    
    func startRequest<T: Codable>(api: MarvelAPIs, onComplete: @escaping (MarvelAPIsResult<T>) -> Void) {
        repository.startRequest(api: api, onComplete: onComplete)
    }
    
    func showActivityIndicator() {
        activityIndicator.show()
    }
    
    func dismissActivityIndicator() {
        activityIndicator.dismiss()
    }
}
