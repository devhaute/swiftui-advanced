//
//  DataService.swift
//  swiftui-advanced
//
//  Created by Tom Lee on 2023/10/25.
//

import Foundation

final class AdvancedCombineDataService {
    @Published private(set) var basicPublisher: [String] = []
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.basicPublisher = ["one", "two", "three"]
        }
    }
}
