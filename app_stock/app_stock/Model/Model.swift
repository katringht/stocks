//
//  Model.swift
//  app_stock
//
//  Created by Ekaterina Tarasova on 23.03.2021.
//

import SwiftUI
import RealmSwift

class Model: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
    @objc dynamic var regularprice = ""
    @objc dynamic var pricechange = ""
    @objc dynamic var isFavorite = false
}
