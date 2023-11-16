//
//  UnitTestingViewModel.swift
//  swiftui-advanced
//
//  Created by kai on 11/16/23.
//

import Foundation

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
    }
}
