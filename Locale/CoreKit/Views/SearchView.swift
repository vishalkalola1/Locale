//
//  SearchView.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import Foundation
import SwiftUI

struct SearchView: View {
    
    @State private var text: String = ""
    
    var action: (String) -> Void
    
    init(action: @escaping (String) -> Void) {
        self.action = action
    }
    
    var body: some View {
        HStack {
            TextField("Enter radius to search near places", text: $text)
                .padding(5)
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
            Button("Search") {
                action(text)
            }
        }.padding(.horizontal, 5)
    }
}
