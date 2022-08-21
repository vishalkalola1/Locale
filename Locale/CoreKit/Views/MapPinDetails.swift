//
//  MapPinDetails.swift
//  Locale
//
//  Created by vishal on 8/21/22.
//

import SwiftUI

struct MapPinDetails: View {
    
    @ObservedObject var place: Place
    
    private var offSet: CGFloat {
        place.isExpand ? -64.0 : -30.0
    }
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 15, height: 15, alignment: .center)
                .foregroundColor(.red)
            PinPopover(isPin: !place.isExpand)
                .foregroundColor(place.isExpand ? .white : .yellow)
                .shadow(radius: 2, x: 2, y: 2)
                .offset(x: 0, y: offSet)
            if !place.isExpand {
                ImageView(url: place.imageUrl)
                    .offset(x: 0, y: offSet)
            } else {
                MapDetails(name: place.name ?? "", address: place.location?.formattedAddress ?? "", categories: place.categories ?? [])
                    .offset(x: 0, y: -65)
            }
        }
        .frame(width: place.isExpand ? 200 : 25, height: place.isExpand ? 100 : 50, alignment: .center)
        .onTapGesture {
            withAnimation {
                place.isExpand.toggle()
            }
        }
    }
}
