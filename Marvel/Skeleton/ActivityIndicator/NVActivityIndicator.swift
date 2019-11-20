//
//  NVActivityIndicator.swift
//  Marvel
//
//  Created by Magy Elias on 8/7/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

struct NVActivityIndicator: ActivityIndicator {
    
    private let activityData: ActivityData = {
        let size = CGSize(width: 100, height: 100)
        let messageFont = UIFont.systemFont(ofSize: 16)
        
        return ActivityData(size: size, messageFont: messageFont, type: .ballClipRotateMultiple)
    }()
    
    init() { }
    
    func show() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.setMessage(nil)
        }
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    func dismiss() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}
