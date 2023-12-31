//
//  ListItem.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import Foundation

protocol ListItemProtocol {

}

struct ListItem: ListItemProtocol {
    let nameOfCar: String
    let modelName: String
    let transmissionName: String
    let year: String
    let power: String
    let imageCarString: String
    let imageOfOwner: String
    let nameOfOwner: String
}

struct ListItemPosts: ListItemProtocol {
    let photoMain: String
    let dateText: String
    let commentText: String
    let numberOfLikes: Int
    let numberOfComments: Int
}

