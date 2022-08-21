//
//  NameView.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct NameView: View {
    
    let name: String
    let size: CGFloat
    
    init(name: String, size: CGFloat = 13.0) {
        self.name = name
        self.size = size
    }
    
    var body: some View {
        Text(name)
            .font(.system(size: size))
            .bold()
            .foregroundColor(.black)
    }
}
