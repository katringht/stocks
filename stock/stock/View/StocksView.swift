//
//  StocksView.swift
//  app_stock
//
//  Created by Ekaterina Tarasova on 23.03.2021.
//

import SwiftUI
import RealmSwift


//MARK: Stock View

struct Stocks: View {
    @State var stock = [Stock]()
    @Binding var text : String
    @Binding var isHide: Bool
    @EnvironmentObject var datamodel: DataModel
    
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0 ){
                
                // for dinamic search bar when user scroll
                GeometryReader{ reader -> AnyView in
                    let yAxis = reader.frame(in: .global).minY
                    
                    if yAxis < 0 && !isHide{
                        DispatchQueue.main.async{
                            withAnimation{
                                isHide = true
                            }
                        }
                    }
                    
                    if yAxis > 0 && isHide{
                        DispatchQueue.main.async{
                            withAnimation{
                                isHide = false
                            }
                        }
                    }
                    return AnyView(
                        Text("")
                            .frame(width: 0, height: 0)
                    )
                }
                .frame(width: 0, height: 0)
                
                // stock cells
                
                ForEach(stockSearchText(), id: \.self){ i in
                    
                    VStack {
                        
                        HStack{
                            ZStack{
                                Image("fon")
                                    .cornerRadius(17.0)
                                Text(i.symbol.prefix(1))
                                    .foregroundColor(.white)
                                    .font(Font.custom("Hiragino Sans W6", size: 25))
                            }
                            VStack(alignment: .leading, spacing: 15){
                                HStack{
                                    Text(i.symbol)
                                        .font(Font.custom("Hiragino Sans W6", size: 15))
                                        .foregroundColor(.black)
                                    StarButton(text: i.symbol, subtitle: i.longName, regular: "\(i.regularMarketPrice)", change: "\(i.regularMarketDayRange)")
                                        .environmentObject(datamodel)
                                }
                                Text(i.longName).font(.caption)
                                    .font(Font.custom("Hiragino Sans W6", size: 18))
                                    .foregroundColor(.black)
                            }
                            
                            Spacer()
                            
                            let myDouble = i.regularMarketPrice
                            let doubleStr = String(format: "%.2f", myDouble)
                            
                            VStack(alignment: .trailing, spacing: 15){
                                Text("$\(doubleStr)")
                                    .font(Font.custom("Hiragino Sans W5", size: 20))
                                    .foregroundColor(.black)
                                Text("\(i.regularMarketDayRange)")
                                    .font(.caption)
                                    .font(Font.custom("Hiragino Sans W5", size: 18))
                                    .foregroundColor(.green)
                            }
                        }
                        .background(Color(.systemGray6))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(17.0)
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
            }
        }
        
        
        .onAppear(perform: loadData)
    }
    
    // json parser
    func loadData() {
        guard let url = URL(string: "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1&apikey=demo") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(StocksApi.self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        self.stock = decodedResponse.quotes
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    //func for searching
    func stockSearchText() -> [Stock] {
        return stock.filter({ text.isEmpty ? true : $0.longName.contains(text) })
    }
}

