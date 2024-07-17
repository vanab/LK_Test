//
//  ImagesListView.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 17.06.2024.
//

import SwiftUI

struct ImagesListView: View {
    
    @StateObject var presenter: ImageListPresenter
    @State private var isRefreshing = false
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 300, maximum: 500))]) {
                Section {
                    ForEach(presenter.images) { image in
                        ImageTile(image: image) {
                            presenter.openDetail(imageModel: image)
                        }
                    }
                } footer: {
                    if let errorMessage = presenter.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                        Spacer()
                        Button {
                            Task {
                                await presenter.loadImages()
                            }
                        } label: {
                            Text("Retry")
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                    else {
                        ProgressView()
                            .frame(height: 100)
                            .onAppear {
                                Task {
                                    await presenter.loadImages()
                                }
                            }
                    }
                }
            }
        }
        .refreshable {
            isRefreshing = true
            await presenter.loadImages(reload: true)
            isRefreshing = false
        }
        .background(Color(UIColor.systemGray6))
        .navigationTitle("Images")
        .navigationBarTitleDisplayMode(.inline) // Баг с прыжком large titles до сих пор не поправлен
        
    }
}

struct ImageTile: View {
    let image: ImageModel
    var buttonTapped: () -> Void
    @StateObject private var loader = ImageLoader()
    @State private var isImageLoaded = false
    @State private var isPressed = false
    
    var body: some View {
        Button {
            buttonTapped()
        } label: {
            VStack {
                if let loadedImage = loader.image {
                    ZStack {
                        Rectangle()
                            .frame(width: 300, height: 300)
                            .foregroundStyle(Color.gray.opacity(0.3))
                            .clipped()
                            
                        loadedImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 300)
                            .background(.clear)
                            .clipped()
                            .opacity(isImageLoaded ? 1.0 : 0.0)
                            .onAppear {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    isImageLoaded = true
                                }
                            }
                    }
                    .cornerRadius(8)
                    .shadow(radius: isPressed ? 15 : 2)
                } else {
                    ProgressView()
                        .frame(width: 300, height: 300)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                        .shadow(radius: isPressed ? 15 : 2)
                }
                Text(image.title)
            }
        }
        .buttonStyle(GrowingButton(changedPressedState: { isPressed in
            if self.isPressed != isPressed {
                DispatchQueue.main.async {
                    self.isPressed = isPressed
                }
            }
        }))
        .animation(.easeInOut(duration: 0.2), value: isPressed)
        .onAppear {
            loader.load(from: image.mediumUrl)
        }
    }
}

struct GrowingButton: ButtonStyle {
    var changedPressedState: (Bool) -> Void
    @State var isPressed: Bool = false
    func makeBody(configuration: Configuration) -> some View {
        changedPressedState(configuration.isPressed)
        return configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(configuration.isPressed ? .easeIn(duration: 0.2) : .easeOut(duration: 0.1), value: configuration.isPressed)
    }
}


#Preview {
    ImagesListView(presenter: ImageListPresenter(output: .init(goToDetail: { _ in })))
}
