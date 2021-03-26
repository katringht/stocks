//
//  ChartsView.swift
//  stock
//
//  Created by Ekaterina Tarasova on 26.03.2021.
//

import SwiftUI
import SwiftUICharts

struct ChartsView: View {
    @State var text: String
    @State var subtitle: String
    
    var recently = ["Wix.com", "FirstEnergy"]
    
    var body: some View {
        VStack{
            LineView(data: [8,23,54,32,12,37,16,23,50], title: text, legend: subtitle, style: ChartStyle(backgroundColor: .white, accentColor: Color.blue, gradientColor: GradientColor.init(start: Color.gray, end: Color.black), textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.black))
            
        }
        .padding()
    }
}
//
//struct ChartsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartsView()
//    }
//}
