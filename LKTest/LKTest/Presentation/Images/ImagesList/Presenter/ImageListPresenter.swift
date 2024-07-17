//
//  ImageListPresenter.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 10.07.2024.
//

import Foundation
import SwiftUI

struct ImageModel: Identifiable, Equatable {
    let id: Int
    let mediumUrl: URL
    let fullSizeUrl: URL
    let title: String
    let height: Double
    let width: Double
    
    init(photoResponse: PhotoResponse) {
        id = photoResponse.id
        mediumUrl = URL(string: photoResponse.src.medium)!
        fullSizeUrl = URL(string: photoResponse.src.original)!
        title = photoResponse.photographer
        height = photoResponse.height
        width = photoResponse.width
    }
}

class ImageListPresenter: ObservableObject {
    
    struct Output {
        var goToDetail: (ImageModel) -> Void
    }
    
    var output: Output
    
    @Published var images: [ImageModel] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private var currentPage = 1
    private let pexelsAPI = PexelsAPI()
    
    init(output: Output) {
        self.output = output
    }
    
    
    func loadImages(reload: Bool = false) async {
        guard !isLoading else { return }
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        do {
            if reload {
                currentPage = 1
            }
            let response = try await pexelsAPI.fetchCuratedPhotos(page: currentPage)
            
            DispatchQueue.main.async {
                self.isLoading = false
                if reload {
                    self.images = []
                }
                self.images.append(contentsOf:
                                                response.photos.map {
                    ImageModel(photoResponse: $0)
                })
            }
            currentPage += 1
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func refreshImages() {
        
    }
    
    func openDetail(imageModel: ImageModel) {
        output.goToDetail(imageModel)
    }
    
}
