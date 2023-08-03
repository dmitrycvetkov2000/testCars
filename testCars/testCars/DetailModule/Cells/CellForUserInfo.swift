//
//  CellForUserInfo.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import Foundation

import UIKit

class CellForUserInfo: UICollectionViewCell {
    
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let photoOfCar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .blue
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainInfoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nestedStack: UIStackView = {
        let nestedStack = UIStackView()
        nestedStack.axis = .horizontal

        return nestedStack
    }()
    
    private let nameOfOwnerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let photoOfOwner: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    var imageCache = NSCache<AnyObject, AnyObject>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMainTitleLabelLabel()
        setupPhotoCar()
        setupStack()
        setConstraints()
        
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMainTitleLabelLabel() {
        addSubview(mainTitleLabel)
    }
    
    func setupPhotoCar() {
        addSubview(photoOfCar)
    }
    
    func setupStack() {
        addSubview(stack)
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
            mainTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            photoOfCar.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 0),
            photoOfCar.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            photoOfCar.heightAnchor.constraint(equalToConstant: CGFloat(self.bounds.size.height / 2)),
            photoOfCar.widthAnchor.constraint(equalToConstant: CGFloat(self.bounds.size.height / 2)),
            
            stack.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 0),
            stack.leftAnchor.constraint(equalTo: photoOfCar.rightAnchor, constant: 0),
        ])
    }
}
