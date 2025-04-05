//
//  PhotoModel.swift
//  ImagemStream
//
//  Created by Rafael Gonzaga on 3/25/25.
//

import Foundation
import PexelsSwift

 
// Modelo de foto da API Pexels
 

struct PhotoModel: Identifiable {
    var id: Int
    var url: String
    var photographer: String
    var photographerURL: String
    var sources: [String: String]

    init(from photoData: PSPhoto) {
        self.id = photoData.id
        self.url = photoData.url
        self.photographer = photoData.photographer
        self.photographerURL = photoData.photographerURL
        self.sources = photoData.source
    }
}
