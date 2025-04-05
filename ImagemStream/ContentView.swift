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
                Color.white.ignoresSafeArea()

                if let photo = imageService.photo,
                   let urlString = photo.sources[selectedSize.rawValue],
                   let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: selectedSize.displayHeight)
                                .padding()
                                .shadow(radius: 20)
                          
                        case .failure:
                            Text("Erro ao carregar imagem")
                                .foregroundColor(.gray)
                                .font(.headline)
                        case .empty:
                            ProgressView("Carregando imagem...")
                                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
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
                        .padding(.bottom)
                    }
                }
            }
            .navigationTitle("ImageStream")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
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
