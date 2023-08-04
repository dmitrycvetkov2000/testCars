//
//  NetworkManager.swift
//  testCars
//
//  Created by Дмитрий Цветков on 02.08.2023.
//

import Foundation

import Foundation

protocol NetworkManagerProtocol {
    func getCars(page: Int, completion: @escaping (Result<MainCars?, Error>) -> Void)
    func getMainInfoAboutCarAndOwner(carId: Int, completion: @escaping (Result<MainInfoAboutCar?, Error>) -> Void)
    func getPosts(carId: Int, page: Int, completion: @escaping (Result<Post?, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func getCars(page: Int, completion: @escaping (Result<MainCars?, Error>) -> Void) {
        let urlString = "http://am111.05.testing.place/api/v1/cars/list?items=10&page=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let obj = try JSONDecoder().decode(MainCars.self, from: data)
                    completion(.success(obj))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getMainInfoAboutCarAndOwner(carId: Int, completion: @escaping (Result<MainInfoAboutCar?, Error>) -> Void) {
        let urlString = "http://am111.05.testing.place/api/v1/car/\(carId)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let obj = try JSONDecoder().decode(MainInfoAboutCar.self, from: data)
                    completion(.success(obj))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getPosts(carId: Int, page: Int, completion: @escaping (Result<Post?, Error>) -> Void) {
        let urlString = "http://am111.05.testing.place/api/v1/car/\(carId)/posts?page=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let obj = try JSONDecoder().decode(Post.self, from: data)
                    completion(.success(obj))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
