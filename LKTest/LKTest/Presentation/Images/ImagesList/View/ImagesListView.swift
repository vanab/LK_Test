//
//  ImagesListView.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 17.06.2024.
//

import SwiftUI

struct ImagesListView: View {
    
    var presenter: ImageListPresenterProtocol
    
    var body: some View {
        VStack {
            Text("Images List View")
            Button(action: {
                self.presenter.openDetail(id: 0)
            }) {
                Text("Go to detail")
            }
        }.navigationTitle("List")
    }
}

#Preview {
    ImagesListView(presenter: ImageListPresenter(output: .init(goToDetail: { _ in })))
}
