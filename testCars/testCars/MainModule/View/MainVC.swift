//
//  ViewController.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import UIKit

class MainVC: UIViewController {
    
    var viewModel: MainViewModelProtocol?
    private lazy var spinner: CustomSpinnerSimple = {
        let squareLength: CGFloat = 50
        let spinner = CustomSpinnerSimple(squareLength: squareLength)
        spinner.frame.origin = CGPoint(x: Int(view.bounds.size.width - squareLength) / 2, y: Int(view.bounds.size.height - squareLength / 2 * 2))

        return spinner
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: CGFloat(view.bounds.size.width / 2 - 10 - 15), height: CGFloat(view.bounds.size.height / 3 - 15 - 15))
        layout.sectionInset = .init(top: 15, left: 15, bottom: 15, right: 15)
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

        viewModel?.getAutomobils(page: 1, completion: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let viewModel = self.viewModel as? MainViewModel {
            return viewModel.paginationAuto.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        
        if let viewModel = self.viewModel as? MainViewModel {
            cell.createImage(imageString: viewModel.paginationAuto[indexPath.row].image ?? "")
            let text = "\((viewModel.paginationAuto[indexPath.row].brandName ?? "") ) \((viewModel.paginationAuto[indexPath.row].modelName ?? "") )  \(viewModel.paginationAuto[indexPath.row].transmissionName?.rawValue ?? "") \(viewModel.paginationAuto[indexPath.row].year ?? 0) г."
            cell.createLabel(text: text)
        } else {
            cell.createImage(imageString: "")
            cell.label.text = "Null"
        }
        
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height) {            
            beginBathFetch()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let networkManager = viewModel?.networkManager {
            viewModel?.router?.showDetailViewController(networkManager: networkManager, carId: viewModel?.paginationAuto[indexPath.row].id ?? 0)
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
        
        if let viewModel = self.viewModel as? MainViewModel {
            viewModel.page += 1
            viewModel.getAutomobils(page:  viewModel.page) {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.stopSpinner()
                }
            }
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
