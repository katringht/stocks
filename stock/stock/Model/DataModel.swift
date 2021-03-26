//
//  DataModel.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 26.03.2021.
//

import SwiftUI
import RealmSwift

class DataModel: ObservableObject {
    @Published var models: [Model] = []
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
    
    // func for adding data to database
    func addData(title: String, detail: String, change: String, regular: String) {
        
        let model = Model()
        model.title = title
        model.detail = detail
        model.pricechange = change
        model.regularprice = regular
        
        //getting refrence
        
        guard let dbRef = try? Realm()  else {return}
        
        //writing data
        do {
            try? dbRef.write{
                
                dbRef.add(model, update: .all)
                //updating ui
                fetchData()
            }
        }
    }
    
    func deleteData(obj: Model) {
        guard let dbRef = try? Realm()  else {return}
        
        try? dbRef.write{
            dbRef.delete(obj)
            
            fetchData()
        }
    }
    
}

