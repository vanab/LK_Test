//
//  ImageListPresenterProtocol.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 10.07.2024.
//

import Foundation

protocol ImageListPresenterProtocol: AnyObject {
    func loadImages()
    func refreshImages()
    func openDetail(id: Int)
}

