//
//  ListSection.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import Foundation

enum ListSection {
    case menuScrollMini([ListItem])
    case buttons([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .menuScrollMini(let items),
                .buttons(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var headerTitle: String {
        switch self {
        case .menuScrollMini(_):
            return "Сведения о Вас"
        case .buttons(_):
            return "Функции приложения"
        }
    }
}
