//
//  UIImageView+Thumbnail.swift
//  Marvel
//
//  Created by Magy Elias on 8/8/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func download(image url: String) {
        guard let imageURL = URL(string:url) else {
            return
        }
        self.kf.setImage(with: ImageResource(downloadURL: imageURL))
    }
}
