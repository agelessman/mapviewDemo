//
//  EditView.swift
//  MapViewDemo
//
//  Created by MC on 2020/2/15.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI
import MapKit

struct EditView: View {
    @ObservedObject var selectedPlace: MKPointAnnotation
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("输入标题", text: $selectedPlace.wrappedTitle)
                    TextField("输入描述", text: $selectedPlace.wrappedSubtitle)
                }
            }
            .navigationBarTitle("编辑")
            .navigationBarItems(trailing: Button("完成") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

