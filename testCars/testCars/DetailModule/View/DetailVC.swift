//
//  DetailVC.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import UIKit

class DetailVC: UIViewController {
    var viewModel: DetailViewModelProtocol?
    var helper: HelperForCollectionView!
    
    lazy var menuScrollMini: ListSection? = {
        .menuScrollMini([.init(nameOfCar: (viewModel?.car.brandName)!,
                               modelName: (viewModel?.car.modelName)!,
                               transmissionName: (viewModel?.car.transmissionName!.rawValue)!,
                               year: "\(viewModel?.car.year ?? 0) г.",
                               power: ((viewModel?.car.engineVolume)!),
                               imageCarString: (viewModel?.car.image)!,
                               imageOfOwner: (viewModel?.car.thumbnail)!,
                               nameOfOwner: (viewModel?.car.name)!)
                        ])
    }()
    
    lazy var menuScrollButtons: ListSection? = {
        .buttons([.init(nameOfCar: "", modelName: "", transmissionName: "", year: "", power: "", imageCarString: "", imageOfOwner: "", nameOfOwner: ""),
        ])
    }()
    
    var pageData: [ListSection] {
        [menuScrollMini!, menuScrollButtons!]
    }

    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.helper = HelperForCollectionView()
        helper.sections = pageData
        
        setupViews()
        setConstraints()
        setDelegates()
    }
}

extension DetailVC {
    private func setDelegates() {
        collectionView.delegate = self.helper
        collectionView.dataSource = self.helper
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.register(CellForUserInfo.self, forCellWithReuseIdentifier: helper.identifierForMini)
        collectionView.register(CellForComments.self, forCellWithReuseIdentifier: helper.identifierForButtons)
        
        collectionView.collectionViewLayout = helper.createLayout()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}


