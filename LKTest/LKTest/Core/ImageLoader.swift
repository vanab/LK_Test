//
//  ImageLoader.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 10.07.2024.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    
    private static var cache: [URL: Image] = [:]
    
    func load(from url: URL) {
        if let cachedImage = ImageLoader.cache[url] {
            self.image = cachedImage
            return
        }
        
        Task {
            if let data = try? Data(contentsOf: url), let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                DispatchQueue.main.async {
                    ImageLoader.cache[url] = image
                    self.image = image
                }
            }
        }
    }
    
}


