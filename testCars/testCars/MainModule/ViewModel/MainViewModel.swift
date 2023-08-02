//
//  MainViewModel.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import Foundation

protocol MainViewModelProtocol {
    init(model: MainModel)
}

class MainViewModel: MainViewModelProtocol {
    var model: MainModel
    
    required init(model: MainModel) {
        self.model = model
    }
}
