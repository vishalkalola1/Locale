//
//  Segment.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct Segment: View {
    
    enum ViewStyle: String {
        case Map
        case List
    }
    
    @Binding var selection: ViewStyle
    private let data: [ViewStyle]
    
    init(selection: Binding<ViewStyle>, data: [ViewStyle]) {
        self._selection = selection
        self.data = data
    }
    
    var body: some View {
        VStack {
            Picker("Change View", selection: $selection) {
                ForEach(data, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(5)
    }
}
