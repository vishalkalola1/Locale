//
//  SearchPlacesView.swift
//  Locale
//
//  Created by vishal on 8/18/22.
//

import SwiftUI
import MapKit

struct SearchPlacesView: View {
    
    @StateObject var viewModel = SearchPlacesViewModel()
    
    @State var radius = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter radius to search near places", text: $radius)
                        .padding(5)
                        .background(.gray.opacity(0.4))
                        .cornerRadius(10)
                    Button("Search") {
                        viewModel.searchPlaces(radius)
                    }
                }.padding(.horizontal, 5)
                Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true, annotationItems: viewModel.places) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        MapPin(place: place)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Places")
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                viewModel.searchPlaces(radius)
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct DropPin: Shape {
    var startAngle: Angle = .degrees(180)
    var endAngle: Angle = .degrees(0)
    
    var isPin: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if isPin {
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addCurve(to: CGPoint(x: rect.minX, y: rect.midY),
                          control1: CGPoint(x: rect.midX, y: rect.maxY),
                          control2: CGPoint(x: rect.minX, y: rect.midY + rect.height / 4))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                          control1: CGPoint(x: rect.maxX, y: rect.midY + rect.height / 4),
                          control2: CGPoint(x: rect.midX, y: rect.maxY))
        } else {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX + 10, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY + 10))
            path.addLine(to: CGPoint(x: rect.midX - 10, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
        return path
    }
}

struct MapPin: View {
    
    @ObservedObject var place: Place
    
    @State var expand: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 10, height: 10, alignment: .center)
                .foregroundColor(.red)
            DropPin(isPin: !expand)
                .frame(width: expand ? 230 : 25, height: expand ? 130 : 50, alignment: .center)
                .foregroundColor(expand ? .white : .yellow)
                .shadow(radius: 2, x: 2, y: 2)
                .offset(x: 0, y: expand ? -80 : -30)
            if !expand {
                AsyncImage(url: place.imageUrl) { image in
                    image
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .background(.white.opacity(0.3))
                        .clipShape(Circle())
                        .shadow(radius: 2, x: 2, y: 2)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 18, height: 15, alignment: .center)
                        .background(.white.opacity(0.3))
                        .clipShape(Circle())
                        .shadow(radius: 2, x: 2, y: 2)
                }
                .offset(x: 0, y: expand ? -64 : -30)
            } else {
                VStack(alignment: .center, spacing: 5) {
                    Spacer().frame(width: 0, height: 5, alignment: .center)
                    Text(place.name ?? "")
                        .font(.system(size: 15))
                        .bold()
                        .foregroundColor(.black)
                        .lineLimit(nil)
                    Text(place.location?.formattedAddress ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                    HStack(alignment: .center, spacing: 5) {
                        ForEach(place.categories!, id: \.id) { category in
                            VStack {
                                Text(category.name ?? "")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                AsyncImage(url: category.imageUrl) { image in
                                    image
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .foregroundColor(.red)
                                } placeholder: {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 18, height: 15, alignment: .center)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(5)
                            .background(.yellow)
                            .cornerRadius(5)
                        }
                    }
                }
                .padding(5)
                .frame(width: expand ? 230 : 25, height: expand ? 130 : 50, alignment: .center)
                .offset(x: 0, y: -80)
            }
        }
        .frame(width: 10, height: 10, alignment: .center)
        .onTapGesture {
            withAnimation {
                expand.toggle()
            }
        }
    }
}

struct SearchPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesView()
    }
}
