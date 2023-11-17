//
//  UnitTestingViewModel.swift
//  swiftui-advanced
//
//  Created by kai on 11/16/23.
//

import Foundation

enum DataError: LocalizedError {
    case noData
    case itemNotFound
}

extension UnitTestingView {
    class UnitTestingViewModel: ObservableObject {
        @Published var isPremium: Bool
        @Published var dataArray: [String] = []
        @Published var selectedItem: String? = nil
        
        init(isPremium: Bool) {
            self.isPremium = isPremium
        }
        
        func addItem(item: String) {
            guard !item.isEmpty else { return }
            self.dataArray.append(item)
        }
        
        func selectItem(item: String) {
            guard !item.isEmpty else { return }
            selectedItem = dataArray.first { $0 == item }
        }
        
        func saveItem(item: String) throws {
            guard !item.isEmpty else {
                throw DataError.noData
            }
            
            if let data = dataArray.first(where: { $0 == item }) {
                // 데이터 DB 저장 로직
            } else {
                throw DataError.itemNotFound
            }
        }
    }
}
