//
//  MainViewModel.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import Foundation

protocol MainViewModelProtocol {
    init(networkManager: NetworkManagerProtocol, router: RouterProtocol)
    func getAutomobils(completion: @escaping () -> Void)
}

class MainViewModel: MainViewModelProtocol {
    var auto: [MainCar]?
    var paginationAuto: [MainCar] = []
    var router: RouterProtocol?
    var networkManager: NetworkManagerProtocol?
    
    required init(networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.networkManager = networkManager
        self.router = router
    }
    
    func getAutomobils(completion: @escaping () -> Void) {
        networkManager?.getAuto(completion: { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let auto):
                    self.auto = auto
                    
                    for i in 0..<10 {
                        self.paginationAuto.append(self.auto![i])
                    }
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
