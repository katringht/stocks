//
//  FavoriteView.swift
//  app_stock
//
//  Created by Ekaterina Tarasova on 23.03.2021.
//

import SwiftUI

//MARK: Favorite View

struct Favorites: View {

    @EnvironmentObject var datamodel: DataModel
    
    var body: some View{
        VStack{
            ForEach (datamodel.models){ item in
                VStack {
                    HStack{
                        ZStack{
                            Image("fon")
                                .cornerRadius(17.0)
                            Text(item.title.prefix(1))
                                .foregroundColor(.white)
                                .font(Font.custom("Hiragino Sans W6", size: 25))
                        }
                        VStack(alignment: .leading, spacing: 15){
                            
                            HStack{
                                Text(item.title)
                                    .font(Font.custom("Hiragino Sans W6", size: 15))
                                Button(action: {
                                    withAnimation(){
                                        datamodel.deleteData(obj: item)
                                    }
                                }) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                            
                            Text(item.detail)
                                .font(Font.custom("Hiragino Sans W6", size: 10))
    
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 15){
                            Text("$\(item.regularprice)")
                                .font(Font.custom("Hiragino Sans W5", size: 15))
                            Text("\(item.pricechange)")
                                .font(Font.custom("Hiragino Sans W5", size: 15))
                                .foregroundColor(.green)
                                .font(.caption)
                        }
                    }
                    .background(Color(.systemGray6))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(Color(.systemGray6))
//                    .background(item % 2 == 1 ? Color.yellow : Color.gray)
                    .cornerRadius(17.0)
                    
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 10)
            }
            .onAppear()
            Spacer()
            
        }
    }
}

