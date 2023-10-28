//
//  ContactRowView.swift
//  SwiftDataContacts
//
//  Created by Stephan Dowless on 6/9/23.
//

import SwiftUI
import FaviconFinder

func downloadImageData(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }

struct ItemRowView: View {
    @ObservedObject var item: Item
    
    @State private var imageURL: URL?
    
    
    var body: some View {
        
        HStack {
            
            if imageURL != nil {
                AsyncImage(url: imageURL!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 48, height: 48)
                        .clipShape(.rect(cornerRadius: 8))
                    
                } placeholder: {
                    ProgressView()
                }
            } else {
                Text(item.serviceUrl)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 48, height: 48)
                    .background(Color(.systemGray4))
                    .clipShape(.rect(cornerRadius: 8))
            }

            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.serviceUrl)
                
                Text(item.serviceUsername)
                    .font(.footnote)
            }
        }.task {
            
            do {
                let favicon = try await FaviconFinder(url: URL(string: item.serviceUrl)!).downloadFavicon()

                if !favicon.url.absoluteString.isEmpty {
                    imageURL = favicon.url
                } else {
                    imageURL = nil
                }
               
            } catch let error {
                print("Error: \(error)")
            }
            
        }
    }
}
