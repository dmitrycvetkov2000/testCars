//
//  MainViewModel.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import Foundation

protocol MainViewModelProtocol {
    init(networkManager: NetworkManagerProtocol, router: RouterProtocol)
    var router: RouterProtocol? { get set }
    var networkManager: NetworkManagerProtocol? { get set }
    var paginationAuto: [MainCar] { get set }
    func getAutomobils(page: Int, completion: @escaping () -> Void)
    
}

class MainViewModel: MainViewModelProtocol {
    var paginationAuto: [MainCar] = []
    var router: RouterProtocol?
    var networkManager: NetworkManagerProtocol?
    var page: Int = 1
    
    required init(networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.networkManager = networkManager
        self.router = router
    }
    
    func getAutomobils(page: Int, completion: @escaping () -> Void) {
        networkManager?.getCars(page: page, completion: { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let car):
                    if let car = car {
                        self.paginationAuto.append(contentsOf: (car))
                        completion()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
