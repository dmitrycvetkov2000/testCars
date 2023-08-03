//
//  NetworkManager.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import Foundation

import Foundation

protocol NetworkManagerProtocol {
    func getAuto(completion: @escaping (Result<[MainCar]?, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func getAuto(completion: @escaping (Result<[MainCar]?, Error>) -> Void) {
        let urlString = "http://am111.05.testing.place/api/v1/cars/list"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode([MainCar].self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
