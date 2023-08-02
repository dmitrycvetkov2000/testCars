//
//  ViewController.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import UIKit

class MainVC: UIViewController {
    var viewModel: MainViewModelProtocol?
    var fetchingMore = false
    private lazy var spinner: CustomSpinnerSimple = {
        let squareLength: CGFloat = 50
        let spinner = CustomSpinnerSimple(squareLength: squareLength)
        spinner.frame.origin = CGPoint(x: Int(view.bounds.size.width - squareLength) / 2, y: Int(view.bounds.size.height - squareLength / 2 * 2))

        return spinner
    }()
    
    private var imageCollection: [UIImage] = [UIImage(named: "ИМТ")!, UIImage(named: "Рулетка")!, UIImage(named: "Рецепты")!, UIImage(named: "Финиш")!,
                                              UIImage(named: "Ккал")!, UIImage(named: "Карта")!, UIImage(named: "Калории")!, UIImage(named: "Часы")!,
                                              UIImage(named: "Пальцы")!, UIImage(named: "Руки")!]
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = .init(top: 10, left: 30, bottom: 30, right: 30)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.backgroundColor = .white
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        setupConstraints()
    }
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = imageCollection[indexPath.row]
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBathFetch()
            }
        }
    }
}

extension MainVC {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func beginBathFetch() {
        showSpinner()
        fetchingMore = true
        print("Begin!")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let newImages: [UIImage] = [UIImage(named: "Дом")!, UIImage(named: "Пепси")!, UIImage(named: "Лейбл")!, UIImage(named: "ВК")!, UIImage(named: "Бомба")!, UIImage(named: "Огонь")!]
            newImages.forEach {
                self.imageCollection.append($0)
            }
            self.fetchingMore = false
            self.collectionView.reloadData()
            self.stopSpinner()
        }
    }
    
    func showSpinner() {
        view.addSubview(spinner)
        spinner.startAnimation(delay: 0.04, replicates: 20)
    }
    func stopSpinner() {
        spinner.stopAnimation()
        spinner.removeFromSuperview()
    }
}
