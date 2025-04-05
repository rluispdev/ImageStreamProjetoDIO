//  ContentView.swift
//  ImagemStream
//
//  Created by Rafael Gonzaga on 3/24/25.
//
import SwiftUI
import PexelsSwift

struct ContentView: View {
    @StateObject private var imageService = PexelsImageService()
    @State private var selectedSize: ImageQuality = .original
    @State private var showSizeSheet = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if let photo = imageService.photo,
               let urlString = photo.sources[selectedSize.rawValue],
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .padding()
                    case .failure:
                        Text("Erro ao carregar imagem")
                            .foregroundColor(.white)
                            .font(.headline)
                    case .empty:
                        ProgressView("Carregando imagem...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showSizeSheet = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
                .padding()
                .padding(.top, 20)

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
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .onAppear {
            imageService.checkAndLoadMoreImagesIfNeeded()
            imageService.pickRandomPhoto()
        }
        .sheet(isPresented: $showSizeSheet) {
            SizeSelectionSheet(selectedSize: $selectedSize, isPresented: $showSizeSheet)
        }
    }
}

#Preview {
    ContentView()
}
