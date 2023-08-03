//
//  DetailViewModel.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var router: RouterProtocol? { get set }
    var car: MainCar { get set }
    init(networkManager: NetworkManagerProtocol, router: RouterProtocol, car: MainCar)
}

class DetailViewModel: DetailViewModelProtocol {
    var router: RouterProtocol?
    var networkManager: NetworkManagerProtocol?
    var car: MainCar
    
    required init(networkManager: NetworkManagerProtocol, router: RouterProtocol, car: MainCar) {
        self.router = router
        self.networkManager = networkManager
        self.car = car
    }
    
}
