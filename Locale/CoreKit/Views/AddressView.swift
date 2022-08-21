//
//  AddressView.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct AddressView: View {
    
    let address: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Text("Address: ")
                .font(.system(size: 10))
                .foregroundColor(.black)
            Text(address)
                .font(.system(size: 10))
                .foregroundColor(.gray)
                .lineLimit(2)
        }
    }
}
