//
//  DataService.swift
//  swiftui-advanced
//
//  Created by Tom Lee on 2023/10/25.
//

import Foundation
import Combine

final class AdvancedCombineDataService {
    @Published private(set) var basicPublisher: String = ""
    let currentValueSubject = CurrentValueSubject<String, Never>("")
    
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
        
        for index in 0..<items.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)) {
                self.currentValueSubject.send(items[index]) 
            }
        }
    }
}
