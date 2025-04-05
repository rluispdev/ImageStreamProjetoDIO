//
//  SizeSelectSheet.swift
//  ImageStream
//
//  Created by Rafael Gonzaga on 4/5/25.
//

import Foundation
import SwiftUI

struct SizeSelectionSheet: View {
    @Binding var selectedSize: ImageQuality
    @Binding var isPresented: Bool

    var body: some View {
        NavigationView {
            List {
                ForEach(ImageQuality.allCases, id: \.self) { size in
                    Button(action: {
                        selectedSize = size
                        isPresented = false
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(size.description)
                                    .font(.headline)
                                Text(size.resolutionInfo)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            if selectedSize == size {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Selecione a Qualidade")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Fechar") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
