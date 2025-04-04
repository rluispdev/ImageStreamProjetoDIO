//  ContentView.swift
//  ImagemStream
//
//  Created by Rafael Gonzaga on 3/24/25.
//

import SwiftUI
 
struct ContentView: View {
    @StateObject private var imageService = PexelsImageService()

    var body: some View {
        ZStack {
            if let photo = imageService.photo {
                AsyncImage(url: URL(string: photo.imageUrl)) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                    case .failure:
                        Text("Erro ao carregar imagem")
                            .foregroundColor(.red)
                            .font(.headline)
                    case .empty:
                        VStack {
                            ProgressView("Carregando a imagem...")
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .padding()
                            Text("Aguarde enquanto carregamos a imagem.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            
            VStack {
                
                Spacer()
                if let photo = imageService.photo {
                    Button(action: {
                        imageService.checkAndLoadMoreImagesIfNeeded()
                        imageService.pickRandomPhoto()
                    }) {
                        Text("Fotógrafo: \(photo.photographer)")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .padding(.top, 10)
                            .shadow(radius: 5)
                    }
                }
            }
            .zIndex(1)
        }
        .onAppear {
            imageService.checkAndLoadMoreImagesIfNeeded()
            imageService.pickRandomPhoto()
        }
    }
}

#Preview {
    ContentView()
    
}
