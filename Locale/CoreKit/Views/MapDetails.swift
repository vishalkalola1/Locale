//
//  MapDetails.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct MapDetails: View {
    
    let name: String
    let address: String
    let categories: [Category]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            NameView(name: name)
            AddressView(address: address)
            if !categories.isEmpty {
                CategoriesView(categories: categories)
            }
        }
        .padding(5)
    }
}
