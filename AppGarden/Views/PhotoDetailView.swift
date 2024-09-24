//
//  PhotoEditorView.swift
//  AppGarden
//
//  Created by  Rashid Javed on 24/09/2024.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: FlickrPhoto

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.blue.opacity(0.3)]),
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 30)

            VStack(alignment: .leading, spacing: 16) {
                ZStack {
                    // Glass effect for image container
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.2))
                        .background(BlurView(style: .systemMaterial))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                        .frame(height: 300)
                    
                    AsyncImage(url: URL(string: photo.media.m)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } placeholder: {
                        Color.gray.frame(height: 300)
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Title: \(photo.title)")
                        .font(.title2.bold())
                        .foregroundColor(.black)

                    Text("Author: \(photo.author)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Published: \(photo.published)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    // Render HTML Description using the custom HTMLTextView
                    HTMLTextView(htmlContent: photo.description)
                        .frame(maxWidth: 400, maxHeight: .infinity)
                        .background(BlurView(style: .systemThinMaterial))
                        .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black.opacity(0.2), lineWidth: 1))
                        .shadow(radius: 10)
                }
                .padding()

                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Image Details", displayMode: .inline)
    }
}

// UIViewRepresentable for displaying HTML content in SwiftUI
struct HTMLTextView: UIViewRepresentable {
    var htmlContent: String

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = htmlToAttributedString(htmlContent)
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = htmlToAttributedString(htmlContent)
    }

    // Function to convert HTML string to NSAttributedString
    func htmlToAttributedString(_ html: String) -> NSAttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("Error parsing HTML: \(error)")
            return nil
        }
    }
}

// Custom BlurView for the glassmorphic effect
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}



//#Preview {
//    PhotoDetailView()
//}
