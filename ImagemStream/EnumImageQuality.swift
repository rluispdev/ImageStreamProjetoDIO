//
//  EnumImageQuality.swift
//  ImageStream
//
//  Created by Rafael Gonzaga on 4/5/25.
//
import Foundation

enum ImageQuality: String, CaseIterable, Identifiable {
    case original, large2x, large, medium, small, portrait, landscape, tiny

    var id: String { rawValue }

    var description: String {
        switch self {
        case .original: return "Qualidade Máxima"
        case .large2x: return "Muito Alta"
        case .large: return "Alta"
        case .medium: return "Média"
        case .small: return "Baixa"
        case .portrait: return "Retrato"
        case .landscape: return "Paisagem"
        case .tiny: return "Muito Baixa"
        }
    }

    var resolutionInfo: String {
        switch self {
        case .original: return "Tamanho original"
        case .large2x: return "Aprox. 1300x1880"
        case .large: return "650x940"
        case .medium: return "Altura 350px"
        case .small: return "Altura 130px"
        case .portrait: return "1200x800"
        case .landscape: return "1200x627"
        case .tiny: return "200x280"
        }
    }

    var displayHeight: CGFloat {
        switch self {
        case .original, .large2x: return 500
        case .large: return 400
        case .medium: return 300
        case .small: return 200
        case .portrait: return 350
        case .landscape: return 250
        case .tiny: return 150
        }
    }
}
