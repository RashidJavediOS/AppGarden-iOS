//
//  ImageGridView.swift
//  AppGarden
//
//  Created by  Rashid Javed on 24/09/2024.
//
//

import SwiftUI

struct ImagePlaceholderGrid: View {
    let photos: [FlickrPhoto] // Pass the photos from Flickr API
    
    var body: some View {
        ScrollView { // Enable scrolling
            GeometryReader { geometry in
                let columns = Array(repeating: GridItem(.flexible()), count: numberOfColumns(for: geometry.size))
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(photos, id: \.id) { photo in
                        NavigationLink(destination: PhotoDetailView(photo: photo)) {
                            ImagePlaceholder(photo: photo)
                        }
                        .transition(.scale)
                    }
                }
                .padding()
            }
            .frame(height: calculateGridHeight(for: photos.count)) // Set dynamic height
        }
    }
    
    // Dynamically calculate the number of columns based on width
    func numberOfColumns(for size: CGSize) -> Int {
        let screenWidth = size.width
        // Choose column count based on width to ensure responsiveness
        if screenWidth > 600 {
            return 4 // For landscape mode or larger screens
        } else if screenWidth > 450 {
            return 3
        } else {
            return 2 // For portrait or smaller screens
        }
    }
    
    // Calculate the height of the grid dynamically based on the number of photos
    func calculateGridHeight(for itemCount: Int) -> CGFloat {
        let rows = ceil(Double(itemCount) / Double(numberOfColumns(for: UIScreen.main.bounds.size)))
        return CGFloat(rows) * 200 // Adjust height per item (200 is placeholder height)
    }
}

struct ImagePlaceholder: View {
    let photo: FlickrPhoto
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: photo.media.m)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                    .frame(width: 150, height: 150)
                    .background(Color.purple.opacity(0.5))
                    .cornerRadius(10)
                    .overlay(
                        Image(systemName: "bird")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .opacity(0.7)
                            .shadow(radius: 10)
                    )
            }
        }
    }
}
#Preview {
    ImagePlaceholderGrid(photos: [])
}
