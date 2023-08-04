//
//  CellForUserInfo.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import Foundation

import UIKit

class CellForUserInfo: UICollectionViewCell {
    
    private let generalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        
        return label
    }()
    
    private let photoOfCar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGreen
        return imageView
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .systemGreen
        
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        
        return label
    }()
    
    private let mainInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        
        return label
    }()
    
    private let nestedStack: UIStackView = {
        let nestedStack = UIStackView()
        nestedStack.axis = .horizontal
        nestedStack.spacing = 10
        nestedStack.backgroundColor = .white
        
        return nestedStack
    }()
    
    private let nameOfOwnerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        
        return label
    }()
    
    let photoOfOwner: UIImageView = UIImageView()
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupMainTitleLabelLabel()
        setupStack()
        setConstraints()
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupMainTitleLabelLabel() {
        addSubview(mainTitleLabel)
    }
    
    func setupStack() {
        addSubview(generalStack)
        
        generalStack.addArrangedSubview(photoOfCar)
        generalStack.addArrangedSubview(stack)
        
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(mainInfoLabel)
        stack.addArrangedSubview(nestedStack)
        nestedStack.addArrangedSubview(photoOfOwner)
        nestedStack.addArrangedSubview(nameOfOwnerLabel)
    }
    
    func configurateCell(imageCarName: String, mainTitleLabelText: String, nameLabelText: String, mainInfoText: String, nameOfOwnerText: String, photoOfOwnerText: String) {
        mainTitleLabel.text = mainTitleLabelText
        photoOfCar.load(urlString: imageCarName)
        nameLabel.text = nameLabelText
        mainInfoLabel.text = mainInfoText
        nameOfOwnerLabel.text = nameOfOwnerText
        photoOfOwner.load(urlString: photoOfOwnerText)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            mainTitleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            mainTitleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            mainTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            generalStack.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 0),
            generalStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            generalStack.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            generalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            photoOfCar.widthAnchor.constraint(equalTo: generalStack.heightAnchor, multiplier: 1),
            photoOfCar.heightAnchor.constraint(equalTo: generalStack.heightAnchor, multiplier: 1),
            
            stack.topAnchor.constraint(equalTo: generalStack.topAnchor, constant: 0),
            stack.leftAnchor.constraint(equalTo: photoOfCar.rightAnchor, constant: 0),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            
            photoOfOwner.widthAnchor.constraint(equalTo: photoOfCar.heightAnchor, multiplier: 0.5),
            photoOfOwner.heightAnchor.constraint(equalTo: photoOfCar.heightAnchor, multiplier: 0.5),
        ])
    }
}
