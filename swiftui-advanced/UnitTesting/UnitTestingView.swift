//
//  UnitTestingView.swift
//  swiftui-advanced
//
//  Created by kai on 11/16/23.
//

import SwiftUI

struct UnitTestingView: View {
    @StateObject private var viewModel: UnitTestingViewModel
    
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: .init(isPremium: isPremium))
    }
    
    var body: some View {
        Text(viewModel.isPremium.description)
    }
}

#Preview {
    UnitTestingView(isPremium: false)
}
