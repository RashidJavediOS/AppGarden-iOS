//
//  NetworkLayer.swift
//  AppGarden
//
//  Created by  Rashid Javed on 24/09/2024.
//

import Foundation


// API Fetching Service
class FlickrAPIService: ObservableObject {
    @Published var photos: [FlickrPhoto] = []
    @Published var isLoading: Bool = false

    func fetchImages(for tags: String) {
        let tagsFormatted = tags.replacingOccurrences(of: " ", with: ",")
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tagsFormatted)"
        
        guard let url = URL(string: urlString) else { return }
        
        self.isLoading = true
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(FlickrResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.photos = response.items
                        self.isLoading = false
                    }
                } catch {
                    print("Error decoding: \(error)")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
        }.resume()
    }
}

struct FlickrResponse: Codable {
    let items: [FlickrPhoto]
}
