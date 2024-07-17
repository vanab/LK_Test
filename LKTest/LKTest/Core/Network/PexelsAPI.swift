//
//  Network.swift
//  LKTest
//
//  Created by Dmitriy Kudrin on 10.07.2024.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
}

class PexelsAPI {
    private let apiKey = "IZ5sFZkkjQWj0aV5PdwsDYMO5pTIdTZ461NZlIsCRib561WgnfDebGjD"
    
    func fetchCuratedPhotos(page: Int) async throws -> CuratedListResponse {
        let urlString = "https://api.pexels.com/v1/curated?per_page=20&page=\(page)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        let responseDecoded = try JSONDecoder().decode(CuratedListResponse.self, from: data)
        //sleep(2)
        return responseDecoded
    }
    
}
