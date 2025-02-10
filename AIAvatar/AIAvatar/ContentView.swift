//
//  ContentView.swift
//  AIAvatar
//
//  Created by Sajid Shanta on 5/2/25.
//

import SwiftUI
import ImagePlayground
import PhotosUI


struct ContentView: View {

    @Environment(\.supportsImagePlayground) var supportsImagePlayground
    @State private var imageGenerationCooncept = ""
    @State private var isShowingImagePlayground = false

    @State private var avatarImage: Image?
    @State private var photosPickerItem: PhotosPickerItem?


    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 20) {
                PhotosPicker(selection: $photosPickerItem, matching: .not(.screenshots)) {
                    (avatarImage ?? Image(systemName: "person.circle.fill"))
                        .resizable()
                        .foregroundStyle(.mint)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                }


                VStack(alignment: .leading) {
                    Text("Sajid Hasan")
                        .font(.title.bold())


                    Text("iOS Developer").bold()
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            
            if supportsImagePlayground {
                TextField("Enter avatar description", text: $imageGenerationCooncept)
                    .font(.title3.bold())
                    .padding()
                    .background(.quaternary, in: .rect(cornerRadius: 16, style: .continuous))
                
                Button("Generate Image", systemImage: "sparkles") {
                    isShowingImagePlayground = true
                }
                .padding()
                .foregroundStyle(.mint)
                .fontWeight(.bold)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(.mint, lineWidth: 3)
                )
            }
            else {
                Text("didn't supports Image Playground")
            }

            Spacer()
        }
        .padding(30)
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem, let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) { avatarImage = Image(uiImage: image) }
                }
            }
        }
        .imagePlaygroundSheet(
            isPresented: $isShowingImagePlayground,
            concept: imageGenerationCooncept,
            sourceImage: avatarImage) { url in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        avatarImage = Image(uiImage: image)
                    }
                }
            } onCancellation: {
                imageGenerationCooncept = ""
            }
            
    }
}


#Preview { ContentView() }
