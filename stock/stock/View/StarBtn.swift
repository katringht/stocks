//
//  StarBtn.swift
//  app_stock
//
//  Created by Ekaterina Tarasova on 23.03.2021.
//

import SwiftUI
import RealmSwift

struct StarButton: View {
    @State private var didTap = false
    @State var text: String
    @State var subtitle: String
    @State var regular: String
    @State var change: String
    @EnvironmentObject var datamodel: DataModel
//    let model = Model()
    let realm = try? Realm()
    
    var body: some View {
        Button(action: {
            self.didTap.toggle()
//            let existingStock = realm?.object(ofType: Model.self, forPrimaryKey: Model.primaryKey())
            if  didTap {
                
                datamodel.addData(title: text, detail: subtitle, change: change, regular: regular)
            }
            else {
                print(text, subtitle)
            }
            
        }) {
            if objectExists() == true || didTap{
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            } else{
                Image(systemName: "star.fill")
                    .foregroundColor(Color.gray)
            }
//            Image(systemName: "star.fill")
//                .foregroundColor(didTap ? Color.yellow : Color.gray)
            
        }
    }
    
    func objectExists() -> Bool {
        return realm!.object(ofType: Model.self, forPrimaryKey: Model.primaryKey()) != nil
        }


    
//    func toggleItem(isFavotite: Bool) {
//      datamodel.toggleCompleted()
//        didTap.toggle()
//    }
    
}
