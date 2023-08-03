//
//  DetailViewModel.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var router: RouterProtocol? { get set }
    init(networkManager: NetworkManagerProtocol, router: RouterProtocol)
}

class DetailViewModel: DetailViewModelProtocol {
    var router: RouterProtocol?
    var networkManager: NetworkManagerProtocol?
    
    required init(networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.router = router
        self.networkManager = networkManager
    }
    
}
