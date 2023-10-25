//
//  AdvancedCombineBootcamp.swift
//  swiftui-advanced
//
//  Created by Tom Lee on 2023/10/25.
//

import SwiftUI
import Combine

struct AdvancedCombineBootcamp: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.data, id: \.self) {
                Text($0)
            }
        }
    }
}

struct AdvancedCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedCombineBootcamp()
    }
}

extension AdvancedCombineBootcamp {
    final class ViewModel: ObservableObject {
        @Published var data: [String] = []
        
        var cancellables = Set<AnyCancellable>()
        
        private let dataService: AdvancedCombineDataService
        
        init(_ dataService: AdvancedCombineDataService = AdvancedCombineDataService()) {
            self.dataService = dataService
            configure() 
        }
        
        private func configure() {
            addSubscribers()
        }
        
        private func addSubscribers() {
            dataService.passthroughSubject
//                .first()
//                .first(where: { $0 > 5 })
                .map({ String($0) })
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                } receiveValue: { [weak self] returnedValue in
                    guard let self else { return }
                    self.data.append(returnedValue)
                }
                .store(in: &cancellables)
        }
    }
}

