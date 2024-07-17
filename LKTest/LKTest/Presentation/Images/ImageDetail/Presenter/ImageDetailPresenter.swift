//
//  ImageDetailPresenter.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 10.07.2024.
//

import Foundation

class ImageDetailPresenter: ObservableObject {
    
    let imageModel: ImageModel
    
    init(imageModel: ImageModel) {
        self.imageModel = imageModel
    }
    
}
