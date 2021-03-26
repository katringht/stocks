//
//  ContentView.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 23.03.2021.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: HOME

struct Home: View {
    
    @State var index = 0
    @State var text: String = ""
    @State var isHide = false
    @State var tapTextField = false
    
    var datamodel = DataModel()
    
    var body: some View{
        VStack(spacing: 0){
            if !isHide{
                SearchBar( text: $text, index: $index)
            }
            ZStack{
                if !tapTextField && text.isEmpty{ // when user presses on search field
                    PopularQueries().opacity(self.index == 2 ? 1 : 0)
                }
                if !(self.index == 2) || !text.isEmpty {
                    VStack{ // depending on the index of view
                        segmentedView(index: $index)
                        ZStack{
                            // view with all stocks from json
                            Stocks(text: $text, isHide: $isHide).opacity(self.index == 0 ? 1 : 0)
                                .environmentObject(datamodel)
                            // view with your favorite stocks
                            Favorites().opacity(self.index == 1 ? 1 : 0)
                                .environmentObject(datamodel)
                        }
                    }
                    
                }
            }
            
        }
        .edgesIgnoringSafeArea(.top)
        
    }
}


//MARK: API

struct StocksApi: Codable {
    var quotes: [Stock]
}

struct Stock: Codable, Hashable{
    var symbol: String
    var longName: String
    var regularMarketPrice: Double
    var regularMarketDayRange: String
    
    
}


