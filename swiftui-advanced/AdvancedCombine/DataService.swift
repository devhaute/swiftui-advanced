//
//  DataService.swift
//  swiftui-advanced
//
//  Created by Tom Lee on 2023/10/25.
//

import Foundation

final class AdvancedCombineDataService {
    @Published private(set) var basicPublisher: String = ""
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items = ["one", "two", "three"]
        
        for index in 0..<items.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)) {
                self.basicPublisher = items[index]
            }
        }
    }
}
