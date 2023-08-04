//
//  CellForComments.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import UIKit

class CellForComments: UICollectionViewCell {
    
    private let generalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let imageOfCar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    private let labelForDate: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let labelForComment: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nestedStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    private let nestedLikesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal

        return stack
    }()
    
    private let imageOfLike: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        
        return imageView
    }()
    
    private let labelForNumberOfLikes: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nestedCommentsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        
        return stack
    }()
    
    private let imageOfComments: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        
        return imageView
    }()
    
    private let labelForNumberOfComments: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupStack() {
        addSubview(generalStack)
        
        generalStack.addArrangedSubview(imageOfCar)
        generalStack.addArrangedSubview(labelForDate)
        generalStack.addArrangedSubview(labelForComment)
        generalStack.addArrangedSubview(nestedStack)
        
        nestedStack.addArrangedSubview(nestedLikesStack)
        nestedLikesStack.addArrangedSubview(imageOfLike)
        nestedLikesStack.addArrangedSubview(labelForNumberOfLikes)
        
        nestedStack.addArrangedSubview(nestedCommentsStack)
        nestedCommentsStack.addArrangedSubview(imageOfComments)
        nestedCommentsStack.addArrangedSubview(labelForNumberOfComments)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStack()
        
        setConstraints()
        
        backgroundColor = .lightGray
        
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configurateCell(imageName: String, dateText: String, commentText: String, numberOfLikes: Int, numberOfComments: Int) {
        imageOfCar.load(urlString: imageName)
        labelForDate.text = dateText
        labelForComment.text = commentText
        
        labelForNumberOfLikes.text = "\(numberOfLikes)"
        labelForNumberOfComments.text = "\(numberOfLikes)"
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            generalStack.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            generalStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            generalStack.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            generalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            imageOfCar.topAnchor.constraint(equalTo: generalStack.topAnchor, constant: 0),
            imageOfCar.leftAnchor.constraint(equalTo: generalStack.leftAnchor, constant: 0),
            imageOfCar.rightAnchor.constraint(equalTo: generalStack.rightAnchor, constant: 0),
            imageOfCar.heightAnchor.constraint(equalTo: generalStack.heightAnchor, multiplier: 0.6),
            
            labelForDate.topAnchor.constraint(equalTo: imageOfCar.bottomAnchor, constant: 0),
            labelForDate.leftAnchor.constraint(equalTo: generalStack.leftAnchor, constant: 4),
            labelForDate.rightAnchor.constraint(equalTo: generalStack.rightAnchor, constant: 0),
            labelForDate.heightAnchor.constraint(equalToConstant: 10),
            
            labelForComment.topAnchor.constraint(equalTo: labelForDate.bottomAnchor, constant: 0),
            labelForComment.leftAnchor.constraint(equalTo: generalStack.leftAnchor, constant: 4),
            labelForComment.rightAnchor.constraint(equalTo: generalStack.rightAnchor, constant: 0),
            labelForComment.heightAnchor.constraint(equalToConstant: 60),
            
            nestedStack.topAnchor.constraint(equalTo: labelForComment.bottomAnchor, constant: 0),
            nestedStack.leftAnchor.constraint(equalTo: labelForComment.leftAnchor, constant: 4),
            nestedStack.widthAnchor.constraint(equalTo: generalStack.widthAnchor, multiplier: 0.6),
            nestedStack.bottomAnchor.constraint(equalTo: generalStack.bottomAnchor, constant: 0),
            
            imageOfLike.widthAnchor.constraint(equalToConstant: 30),
            imageOfLike.heightAnchor.constraint(equalToConstant: 30),
            
            imageOfComments.widthAnchor.constraint(equalToConstant: 30),
            imageOfComments.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

