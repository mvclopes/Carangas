//
//  Service.swift
//  Carangas
//
//  Created by Matheus Lopes on 15/09/22.
//  Copyright © 2022 Eric Brito. All rights reserved.
//

import Foundation

enum CarServiceError: Error {
    case badURL
    case taskError
    case noResponse
    case invalidStatusCode(Int)
    case noData
    case decodingError
    
    var errorMessage: String {
        switch self {
        case .badURL:
            return "URL inválida"
        case .taskError:
            return "Erro na requisição"
        case .noResponse:
            return "Servidor não respondeu"
        case .invalidStatusCode(let statusCode):
            return "Status Code inválido: \(statusCode)"
        case .noData:
            return "Servidor não retornou dados"
        case .decodingError:
            return "Erro na decodificação dos objetos carros"
        }
    }
}

class CarService {
    private let baseUrl = "https://carangas.herokuapp.com/cars"
    
//    private lazy var session: URLSession = .shared
    private let config: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 30
        configuration.httpAdditionalHeaders = ["Content-Type":"application/json"]
        configuration.httpMaximumConnectionsPerHost = 3
        
        return configuration
    }()
    private lazy var session = URLSession(configuration: config)
    
    func loadCars(onComplete: @escaping (Result<[Car], CarServiceError>) -> Void) {
        guard let url = URL(string: baseUrl) else {
            return onComplete(.failure(.badURL))
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let _ = error {
                return onComplete(.failure(.taskError))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return onComplete(.failure(.noResponse))
            }
            
            // Pattern Match Operator ~=
            if !(200...299 ~= response.statusCode) {
                return onComplete(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                return onComplete(.failure(.noResponse))
            }
            
            do {
                let cars = try JSONDecoder().decode([Car].self, from: data)
                onComplete(.success(cars))
            } catch {
                return onComplete(.failure(.decodingError))
            }
        }
        task.resume()
        
    }
}
