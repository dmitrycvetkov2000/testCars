//
//  ModuleBuilder.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createMain(router: RouterProtocol) -> UIViewController
    func createDetail(router: RouterProtocol, networkManager: NetworkManagerProtocol, carId: Int) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    func createMain(router: RouterProtocol) -> UIViewController {
        let view = MainVC()
        let networkManager = NetworkManager()
        let viewModel = MainViewModel(networkManager: networkManager, router: router)
        view.viewModel = viewModel
        
        return view
    }
    
    func createDetail(router: RouterProtocol, networkManager: NetworkManagerProtocol, carId: Int) -> UIViewController {
        let view = DetailVC()
        let viewModel = DetailViewModel(networkManager: networkManager, router: router, carId: carId)
        view.viewModel = viewModel
        
        return view
    }
}
