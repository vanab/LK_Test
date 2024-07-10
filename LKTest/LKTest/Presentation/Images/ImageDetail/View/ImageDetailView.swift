//
//  ImageDetailView.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 17.06.2024.
//

import SwiftUI

struct ImageDetailView: View {
    
    var presenter: ImageDetailPresenterProtocol
    
    init(presenter: ImageDetailPresenterProtocol) {
        self.presenter = presenter
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ImageDetailView(presenter: ImageDetailPresenter(photoId: 0))
}
