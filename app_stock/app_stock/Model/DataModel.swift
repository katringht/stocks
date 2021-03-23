//
//  DataModel.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 23.03.2021.
//

import SwiftUI
import RealmSwift

class DataModel: ObservableObject {
    @Published var models: [Model] = []
    @Published var updateObject : Model?
    @Published var isFavorite = false
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let dbRef = try? Realm()  else {return}
        
        let results = dbRef.objects(Model.self)
        //displaying results
        self.models = results.compactMap({(model) -> Model? in
            return model
        })
        
    }
    
    func addData(title: String, detail: String, change: String, regular: String) {
        
        let model = Model()
        model.title = title
        model.detail = detail
        model.pricechange = change
        model.regularprice = regular
        
        //getting refrence
        
        guard let dbRef = try? Realm()  else {return}
        
        //writing data
        try? dbRef.write{
            dbRef.add(model)
            
            //updating ui
            fetchData()
        }
    }
    
    func isFavorite(isFavorite: Bool) {
//        let model = Model()
//        model.isFavorite = isFavorite
        guard let dbRef = try? Realm()  else {return}
          try! dbRef.write {
            self.isFavorite = !isFavorite
          }
//        fetchData()
        
    }
    
    func deleteData(obj: Model) {
        guard let dbRef = try? Realm()  else {return}
        
        try? dbRef.write{
            dbRef.delete(obj)
            
            fetchData()
        }
    }
    
//    func setUpInitialData(){
//
//        // Updation...
//
//        guard let updateData = updateObject else{return}
//
//        // Checking if it's update object and assigning values...
//        title = updateData.title
//        detail = updateData.detail
//    }
    
}
