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
    var cars: [MainCar]?
    var paginationAuto: [MainCar] = []
    var router: RouterProtocol?
    var networkManager: NetworkManagerProtocol?
    
    required init(networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.networkManager = networkManager
        self.router = router
    }
    
    func getAutomobils(completion: @escaping () -> Void) {
        networkManager?.getCars(completion: { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let car):
                    self.cars = car
                    
                    for i in 0..<10 {
                        if let car = self.cars?[i] {
                            self.paginationAuto.append((car))
                        }
                    }
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}
