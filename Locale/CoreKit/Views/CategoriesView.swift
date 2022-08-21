//
//  CategoriesView.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct CategoriesView: View {
    
    let categories: [Category]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 5) {
                ForEach(categories, id: \.id) { category in
                    VStack(spacing: 5) {
                        NameView(name: category.name ?? "", size: 10.0)
                        ImageView(url: category.imageUrl)
                    }
                    .padding(5)
                    .frame(maxWidth: 100)
                    .background(.yellow)
                    .cornerRadius(5)
                }
            }
        }
        .frame(height: 45, alignment: .center)
    }
}
