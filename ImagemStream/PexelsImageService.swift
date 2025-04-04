import Foundation
import Combine
import PexelsSwift

class PexelsImageService: ObservableObject {
    @Published var photo: PhotoModel?
    private var allPhotos: [PhotoModel] = [] 
    private var usedPhotos: Set<Int> = Set()
    private var currentPage: Int = 1
    private let imagesPerPage: Int = 40
    private var isFetching: Bool = false
    
    init() {
        guard let apiKey = ProcessInfo.processInfo.environment["PEXELS_API_KEY"], !apiKey.isEmpty else {
            print("⚠️ Insira a chave da API")
            return
        }
        
        PexelsSwift.shared.setup(apiKey: apiKey)
        fetchImages(for: currentPage)
    }
    
    func checkAndLoadMoreImagesIfNeeded() {
        let remainingImages = allPhotos.filter { !usedPhotos.contains($0.id) }
        if remainingImages.count < 10 {
            fetchImages(for: currentPage)
        }
    }
    
    private func fetchImages(for page: Int) {
        guard !isFetching else { return }
        isFetching = true
        
        PexelsSwift.shared.getCuratedPhotos(page: page) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isFetching = false
                
                switch result {
                case .failure:
                    self.photo = nil
                case .success(let successData):
                    let (data, paging, _) = successData
                    let newPhotos = data.map { PhotoModel(from: $0) }
                    
                    self.allPhotos.append(contentsOf: newPhotos)
                    let totalResults = paging.totalResults
                    let totalPages = (totalResults + self.imagesPerPage - 1) / self.imagesPerPage
                    
                    if page < totalPages {
                        self.currentPage += 1
                    }
                    
                    self.pickRandomPhoto()
                }
            }
        }
    }
    
    func pickRandomPhoto() {
        guard !allPhotos.isEmpty else { return }
        
        let availablePhotos = allPhotos.filter { !usedPhotos.contains($0.id) }
        
        if let randomPhoto = availablePhotos.randomElement() {
            self.photo = randomPhoto
            usedPhotos.insert(randomPhoto.id)
            checkAndLoadMoreImagesIfNeeded()
        } else {
            usedPhotos.removeAll()
            pickRandomPhoto()
        }
    }
}
