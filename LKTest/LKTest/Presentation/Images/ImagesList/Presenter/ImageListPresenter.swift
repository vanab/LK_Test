//
//  ImageListPresenter.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 10.07.2024.
//

import Foundation

class ImageListPresenter: ImageListPresenterProtocol {
    
    struct Output {
        var goToDetail: (Int) -> Void
    }
    
    var output: Output
    
    init(output: Output) {
        self.output = output
    }
    
    
    func loadImages() {
        
    }
    
    func refreshImages() {
        
    }
    
    func openDetail(id: Int) {
        output.goToDetail(id)
    }
    
}
