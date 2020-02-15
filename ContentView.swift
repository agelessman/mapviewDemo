//
//  ContentView.swift
//  MapViewDemo
//
//  Created by MC on 2020/2/15.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var showingPlaceDetail = false
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate,
                    annotations: locations,
                    showingPlaceDetail: $showingPlaceDetail,
                    selectedPlace: $selectedPlace)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newAnnotation = CodableMKPointAnnotation()
                        newAnnotation.coordinate = self.centerCoordinate
                        
                        self.locations.append(newAnnotation)
                        
                        self.selectedPlace = newAnnotation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .alert(isPresented: $showingPlaceDetail) {
            Alert(title: Text(selectedPlace?.title ?? "无标题"),
                  message: Text(selectedPlace?.subtitle ?? "无描述"),
                  primaryButton: .default(Text("好的")),
                  secondaryButton: .default(Text("编辑")) {
                    self.showingEditScreen = true
                })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(selectedPlace: self.selectedPlace!)
            }
        }
        .onAppear(perform: laodData)
    }
    
    func laodData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("Palcemark")
        do {
            let data = try Data(contentsOf: fileName)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("读取失败")
        }
    }
    
    func saveData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("Palcemark")
        do {
            let data = try JSONEncoder().encode(locations)
            try data.write(to: fileName, options: [.atomic, .completeFileProtection])
        } catch {
            print("保存失败")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
