//
//  StarBtn.swift
//  app_stock
//
//  Created by Ekaterina Tarasova on 23.03.2021.
//

import SwiftUI

struct StarButton: View {
    @State private var didTap = false
    @State var text: String
    @State var subtitle: String
    @State var regular: String
    @State var change: String
    
    @EnvironmentObject var datamodel: DataModel


    var body: some View {
        Button(action: {
            self.didTap.toggle()
            if didTap{
                print(text, subtitle)
                datamodel.addData(title: text, detail: subtitle, change: change, regular: regular)
                datamodel.isFavorite(isFavorite: didTap)
            }
        }) {
            Image(systemName: "star.fill")
                .foregroundColor(didTap ? Color.yellow : Color.gray)
        }
    }
    
}
