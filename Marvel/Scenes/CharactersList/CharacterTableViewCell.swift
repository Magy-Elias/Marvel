//
//  CharacterTableViewCell.swift
//  Marvel
//
//  Created by Magy Elias on 8/8/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import UIKit

final class CharacterTableViewCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    var characterData: CharacterViewModel? {
        didSet {
            if let characterData = characterData {
                characterNameLabel.text = characterData.name
                
                characterImage.download(image: characterData.image ?? "")
            }
        }
    }
    
    private lazy var characterImage: UIImageView = {
        let image = UIImage(named: "MarvelLogo")

        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17.0)
        return label
    }()
    
    private lazy var characterCellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 20.3
        
        stackView.addArrangedSubview(characterImage)
        stackView.addArrangedSubview(characterNameLabel)
        return stackView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addAndConfigureSubviews()
    }
    
    private func addAndConfigureSubviews() {
        contentView.addSubview(characterCellStackView)
        
        setupCharacterCellStackViewConstraints()
    }
    
    private func setupCharacterCellStackViewConstraints() {
        characterCellStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 14).isActive = true
        characterCellStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -21.2).isActive = true
        characterCellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        characterCellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        
        setupCharacterImageConstraints()
    }
    
    private func setupCharacterImageConstraints() {
        characterImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        characterImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }

    private func setupCharacterNameLabelConstraints() {
        characterNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
