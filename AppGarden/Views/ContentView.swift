//
//  ContentView.swift
//  AppGarden
//
//  Created by  Rashid Javed on 24/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var flickrService = FlickrAPIService()
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText)
                    .onChange(of: searchText) { newValue in
                        if !newValue.isEmpty {
                            flickrService.fetchImages(for: newValue)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal, 20)
                
                if flickrService.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    ScrollView {
                        ImagePlaceholderGrid(photos: flickrService.photos)
                    }
                }
            }
            .navigationBarTitle("Flickr Image Search", displayMode: .inline)
        }
    }
}

#Preview {
    ContentView()
}

