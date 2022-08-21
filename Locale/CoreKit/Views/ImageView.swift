//
//  ImageView.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct ImageView: View {
    
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
        } placeholder: {
            Image(systemName: "photo")
                .resizable()
        }
        .frame(width: 25, height: 25, alignment: .center)
        .background(.red.opacity(0.5))
        .clipShape(Circle())
    }
}
