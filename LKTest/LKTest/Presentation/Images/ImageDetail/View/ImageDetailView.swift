//
//  ImageDetailView.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 17.06.2024.
//

import SwiftUI

struct ImageDetailView: View {
    
    @StateObject var presenter: ImageDetailPresenter
    
    @StateObject private var loader = ImageLoader()
        
    var body: some View {
        ScrollView {
            VStack {
                if let loadedImage = loader.image {
                    loadedImage
                        .resizable()
                        .aspectRatio(presenter.imageModel.width / presenter.imageModel.height, contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray)
                    Text(presenter.imageModel.title)
                        .font(.title)
                        .padding()
                } else {
                    ProgressView()
                        .frame(alignment: .center)
                        .background(Color.white)
                }
            }
        }
        .navigationTitle("Image")
        .onAppear {
            loader.load(from: presenter.imageModel.fullSizeUrl)
        }
    }
}

#Preview {
    return ImageDetailView(presenter: ImageDetailPresenter(imageModel: ImageModel(photoResponse: PhotoResponse(id: 0, height: 0, width: 0, src: .init(medium: "", original: ""), photographer: "test"))))
}
