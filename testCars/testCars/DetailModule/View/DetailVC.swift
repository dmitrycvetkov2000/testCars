//
//  DetailVC.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import UIKit

class DetailVC: UIViewController {
    var viewModel: DetailViewModelProtocol!
    var helper: HelperForCollectionView!
    
    private lazy var spinner: CustomSpinnerSimple = {
        let squareLength: CGFloat = 50
        let spinner = CustomSpinnerSimple(squareLength: squareLength)
        spinner.frame.origin = CGPoint(x: Int(view.bounds.size.width - squareLength) / 2, y: Int(view.bounds.size.height - squareLength / 2 * 2))

        return spinner
    }()
    
    lazy var menuScrollMini: ListSection? = {
        .menuScrollMini([ListItem(nameOfCar: viewModel.moreInfo?.car?.brandName ?? "",
                                  modelName: viewModel.moreInfo?.car?.modelName ?? "",
                                  transmissionName: viewModel.moreInfo?.car?.transmissionName ?? "",
                                  year: "\(viewModel.moreInfo?.car?.year ?? 0) г.",
                                  power: viewModel.moreInfo?.car?.engineVolume ?? "",
                                  imageCarString: viewModel.moreInfo?.car?.images?[0].url ?? "",
                                  imageOfOwner: viewModel.moreInfo?.user?.avatar?.url ?? "",
                                  nameOfOwner: viewModel.moreInfo?.user?.username ?? "")])
    }()
    
    lazy var menuScrollButtons: ListSection? = {
        var mas: [ListItemPosts] = []
            
        for i in 0..<(viewModel?.paginationPosts.count ?? 0) {
            mas.append(.init(photoMain: viewModel?.allPosts[i].img ?? "", dateText: viewModel?.allPosts[i].createdAt ?? "", commentText: viewModel?.allPosts[i].text ?? "", numberOfLikes: (viewModel?.allPosts[i].likeCount ?? 0), numberOfComments: (viewModel?.allPosts[i].commentCount ?? 0)))
        }
        return .buttons(mas)
    }()
    
    var pageData: [ListSection] {
        [menuScrollMini!, menuScrollButtons!]
    }

    let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.backgroundColor = .clear
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        group.enter()
        self.viewModel?.getMoreInfo(carId: self.viewModel?.carId ?? 0) {
            self.group.leave()
        }
        group.enter()
        self.viewModel?.getPosts(carId: self.viewModel?.carId ?? 0, page: self.viewModel?.page ?? 0) {
            self.group.leave()
        }
        
        group.notify(queue: .main) {
            self.helper = HelperForCollectionView()
            self.helper.viewModel = self.viewModel
            self.helper.view = self
            self.helper.sections = self.pageData
            
            self.setupViews()
            self.setConstraints()
            self.setDelegates()
        }
        
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
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func beginBathFetch() {
        showSpinner()
        viewModel?.page += 1
        viewModel?.getPosts(carId: viewModel?.carId ?? 0, page: viewModel?.page ?? 0, completion: {
            self.viewModel?.setPaginationPosts(postsPerPages: self.viewModel?.postsPerPages ?? 0) {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.stopSpinner()
                }
            }
        })
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


