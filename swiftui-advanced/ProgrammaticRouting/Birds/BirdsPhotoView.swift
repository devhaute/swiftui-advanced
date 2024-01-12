//
//  BirdsPhotoView.swift
//  swiftui-advanced
//
//  Created by kai on 1/11/24.
//

import SwiftUI

struct BirdsPhotoView: View {
    let bird: Bird
    
    var body: some View {
        Text(bird.photoURLString)
    }
}

#Preview {
    BirdsPhotoView(bird: .tempData)
}
