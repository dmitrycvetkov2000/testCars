//
//  Router.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assebleBuilder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initiateViewController()
    func showDetailViewController(networkManager: NetworkManagerProtocol, carId: Int)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assebleBuilder: BuilderProtocol?
    
    init(navigationController: UINavigationController, assebleBuilder: BuilderProtocol) {
        self.navigationController = navigationController
        self.assebleBuilder = assebleBuilder
    }
    
    func initiateViewController() {
        if let navigationController = navigationController {
            guard let mainVC = assebleBuilder?.createMain(router: self) else { return }
            navigationController.viewControllers = [mainVC]
        }
    }
    var imageCache = NSCache<AnyObject, AnyObject>()
    func showDetailViewController(networkManager: NetworkManagerProtocol, carId: Int) {
        if let navigationController = navigationController {
            guard let detailVC = assebleBuilder?.createDetail(router: self, networkManager: networkManager, carId: carId) else { return }
            navigationController.pushViewController(detailVC, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
