//
//  DataService.swift
//  swiftui-advanced
//
//  Created by Tom Lee on 11/17/23.
//

import Foundation
import Combine

protocol DataServiceProtocol {
    func downloadItemsWithAsync() async throws -> [String]
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

final class DataService: DataServiceProtocol {
    func downloadItemsWithAsync() async throws -> [String] {
        do {
            try await Task.sleep(nanoseconds: 3_000_000_000)
            return ["비동기 데이터1", "비동기 데이터2", "비동기 데이터3"]
        } catch {
            throw error
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(["비동기 데이터1", "비동기 데이터2", "비동기 데이터3"])
            .delay(for: .seconds(3), scheduler: DispatchQueue.main)
            .tryMap { publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                
                return publishedItems
            }
            .eraseToAnyPublisher()
    }
}
