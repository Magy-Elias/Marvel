//
//  CharacterViewController.swift
//  Marvel
//
//  Created by Magy Elias on 8/8/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import UIKit

final class CharacterViewController: BaseViewController {
    
    // MARK: - Properties Conformance
    var characterPresenter: CharacterPresentationLogic?
    
    // MARK: - IBOutlets
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterDetailsLabel: UILabel!
    
    var characterDetails: CharacterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = characterDetails?.name ?? ""
    }
    
    func configureView() {
        if let characterDetails = characterDetails {
            if let description = characterDetails.description, !description.isEmpty {
                characterDetailsLabel.text = description
            } else {
                characterDetailsLabel.text = "No description"
            }
            
            characterImage.download(image: characterDetails.image ?? "")
        }
    }
}
