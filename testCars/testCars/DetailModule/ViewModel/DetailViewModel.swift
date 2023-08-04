//
//  DetailViewModel.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var router: RouterProtocol? { get set }
    var carId: Int {get set }
    var page: Int { get set }
    var moreInfo: MainInfoAboutCar? { get set }
    var post: Post? { get set }
    var allPosts: [PostElement] { get set }
    var paginationPosts: [PostElement] { get set }
    var postsPerPages: Int { get set }
    func getMoreInfo(carId: Int, completion: @escaping () -> Void)
    func getPosts(carId: Int, page: Int, completion: @escaping () -> Void)
    func setPaginationPosts(postsPerPages: Int, completion: () -> Void)

    init(networkManager: NetworkManagerProtocol, router: RouterProtocol, carId: Int)
}

class DetailViewModel: DetailViewModelProtocol {
    var router: RouterProtocol?
    var networkManager: NetworkManagerProtocol?
    var carId: Int
    var page: Int = 1
    var moreInfo: MainInfoAboutCar?
    var post: Post?
    
    var allPosts: [PostElement] = []
    
    var postsPerPages: Int = 10
    var paginationPosts: [PostElement] = []
    var limit = 10
    
    required init(networkManager: NetworkManagerProtocol, router: RouterProtocol, carId: Int) {
        self.router = router
        self.networkManager = networkManager
        self.carId = carId
    }
        
    func getMoreInfo(carId: Int, completion: @escaping () -> Void) {
        networkManager?.getMainInfoAboutCarAndOwner(carId: carId, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detailInfo):
                    self?.moreInfo = detailInfo
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }

    func getPosts(carId: Int, page: Int, completion: @escaping () -> Void) {
        networkManager?.getPosts(carId: carId, page: page, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detailInfo):
                    self?.post = detailInfo
                    self?.allPosts = detailInfo?.posts ?? []
                    self?.limit = self?.allPosts.count ?? 0
                    for i in 0..<(self?.limit ?? 0) {
                        if let post = detailInfo?.posts?[i] {
                            self?.paginationPosts.append(post)
                        }
                    }
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    func setPaginationPosts(postsPerPages: Int, completion: () -> Void) {
        defer {
            completion()
        }
        
        if postsPerPages >= limit {
            return
        } else if postsPerPages >= limit - 10 {
            for i in postsPerPages..<limit {
                paginationPosts.append(allPosts[i])
            }
            self.postsPerPages += 10
        } else {
            for i in postsPerPages..<postsPerPages + 10 {
                paginationPosts.append(allPosts[i])
            }
            self.postsPerPages += 10
        }
    }
}
