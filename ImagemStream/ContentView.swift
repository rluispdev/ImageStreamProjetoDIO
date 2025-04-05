//  ContentView.swift
//  ImagemStream
//
//  Created by Rafael Gonzaga on 3/24/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var imageService = PexelsImageService()
    @State private var selectedSize: ImageQuality = .original
    @State private var showSizeSheet = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea() // Fundo base preto

                if let photo = imageService.photo,
                   let urlString = photo.sources[selectedSize.rawValue],
                   let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit() // Respeita o "tamanho" da imagem escolhida
                                .padding()     // Dá espaço lateral pra ver o efeito do tamanho
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
                        Spacer()
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
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                     
                    }
                }
            }
            .navigationTitle("ImageStream") // <- Nome do app aqui
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                HStack {
                    Spacer()
                    Button(action: {
                        showSizeSheet = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
                .padding()
                .padding(.top, 20)
            }
            .sheet(isPresented: $showSizeSheet) {
                SizeSelectionSheet(selectedSize: $selectedSize, isPresented: $showSizeSheet)
            }
            .onAppear {
                imageService.checkAndLoadMoreImagesIfNeeded()
                imageService.pickRandomPhoto()
            }
        }
    }
}

#Preview {
    ContentView()
}
