//
//  Model.swift
//  stock
//
//  Created by Ekaterina Tarasova on 26.03.2021.
//

import SwiftUI
import RealmSwift

// model for database

class Model: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
    @objc dynamic var regularprice = ""
    @objc dynamic var pricechange = ""
    @objc dynamic var isFavorite = false
    
    
    override class func primaryKey() -> String? {
        return "title"
    }
}
