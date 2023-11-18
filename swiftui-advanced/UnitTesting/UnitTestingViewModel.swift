//
//  UnitTestingViewModel.swift
//  swiftui-advanced
//
//  Created by kai on 11/16/23.
//

import Foundation
import Combine

extension UnitTestingView {
    class UnitTestingViewModel: ObservableObject {
        @Published var isPremium: Bool
        @Published var items: [String] = []
        @Published var selectedItem: String? = nil
        
        private let dataService: DataServiceProtocol
        private var cancellables = Set<AnyCancellable>()
        
        init(
            isPremium: Bool,
            dataService: DataServiceProtocol = ServiceManager.shared.dataService
        ) {
            self.isPremium = isPremium
            self.dataService = dataService
        }
        
        func addItem(item: String) {
            guard !item.isEmpty else { return }
            self.items.append(item)
        }
        
        func selectItem(item: String) {
            guard !item.isEmpty else { return }
            selectedItem = items.first { $0 == item }
        }
        
        func saveItem(item: String) throws {
            guard !item.isEmpty else {
                throw AppError.noData
            }
            
            if let data = items.first(where: { $0 == item }) {
                // 데이터 DB 저장 로직
            } else {
                throw AppError.itemNotFound
            }
        }
        
        func downloadItemsWithAsync() {
            Task { @MainActor in
                let result = try await dataService.downloadItemsWithAsync()
                self.items = result
            }
        }
        
        func downloadItemWithCombine() {
            dataService.downloadItemsWithCombine()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { [weak self] result in
                    guard let self else { return }
                    self.items = result
                }
                .store(in: &cancellables)
        }
    }
}
