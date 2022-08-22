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
    @FocusState private var isFocused: Bool
    
    var action: (String) -> Void
    
    init(action: @escaping (String) -> Void) {
        self.action = action
    }
    
    var body: some View {
        HStack {
            HStack {
                TextField("Enter radius to search near by places", text: $text)
                    .padding(.vertical, 8)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                Image(systemName: "xmark.circle")
                    .onTapGesture {
                        self.text = ""
                    }
            }
            .padding(.horizontal, 8)
            .background(.gray.opacity(0.1))
            .cornerRadius(15)
            Button("Search") {
                action(text)
                isFocused = false
            }
        }.padding(.horizontal, 5)
    }
}
