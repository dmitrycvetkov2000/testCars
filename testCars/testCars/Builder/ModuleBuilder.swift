//
//  ModuleBuilder.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createMain(router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    func createMain(router: RouterProtocol) -> UIViewController {
        let view = MainVC()
        let model = MainModel()
        let viewModel = MainViewModel(model: model)
        view.viewModel = viewModel
        
        return view
    }
}
