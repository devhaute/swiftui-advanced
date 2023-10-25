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
        VStack {
            ForEach(viewModel.data, id: \.self) { data in
                Text(data)
                    .font(.largeTitle)
                    .foregroundColor(.black)
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
//            dataService.$basicPublisher
//                .sink { completion in
//                    switch completion {
//                    case .finished:
//                        print("finished")
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                } receiveValue: { [weak self] returnedValue in
//                    guard let self else { return }
//                    self.data.append(returnedValue)
//                }
//                .store(in: &cancellables)
            
            dataService.currentValueSubject
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

