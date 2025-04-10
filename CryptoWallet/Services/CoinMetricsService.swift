//
//  CoinMetricsService.swift
//  CryptoWallet
//
//  Created by Ilya Kuznetsov on 10.04.2025.
//

import Foundation

final class CoinMetricsService {
    
    // MARK: - Constants
    
    static let shared = CoinMetricsService()
    
    // MARK: - Private Properties
    
    private let decoder = SnakeCaseJSONDecoder()
    private let urlSession = URLSession.shared
    private var tasks: [String: URLSessionTask] = [:]
    
    // MARK: - Initialisers
    
    private init() {}
    
    // MARK: - Public Methods
    
    func fetchCoinMetrics(
        for coin: String,
        completion: @escaping (Result<CryptoResponse, Error>) -> Void
    ) {
        assert(Thread.isMainThread)
        tasks[coin]?.cancel()
        
        guard let request = makeCoinMetricsRequest(for: coin) else {
            print("Make request fail \(#file)")
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<CryptoResponse, Error>) in
            guard let self else { return }
            switch result {
            case .success(let metrics):
                completion(.success(metrics))
                self.tasks[coin] = nil
            case .failure(let error):
                print("Error in \(#function) \(#file): \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        tasks[coin] = task
        task.resume()
    }
    
    // MARK: - Private Methods
    
    private func makeCoinMetricsRequest(for coin: String) -> URLRequest? {
        let coinMetricsURL = URL(string: "https://data.messari.io/api/v1/assets/\(coin)/metrics")
        
        guard let url = coinMetricsURL else {
            print("Unable to construct URL for Coin Metrics Request")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}
