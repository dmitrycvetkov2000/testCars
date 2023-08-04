//
//  ListSection.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import Foundation

enum ListSection {
    case menuScrollMini([ListItem])
    case buttons([ListItemPosts])
    
    var items: [ListItemProtocol] {
        switch self {
        case .menuScrollMini(let items):
            return items
        case .buttons(let items):
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
