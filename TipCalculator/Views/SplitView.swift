//
//  SplitView.swift
//  TipCalculator
//
//  Created by Joseph Bubb on 8/14/22.
//

import SwiftUI

struct SplitView: View {
    @State var split = 1
    var total: Double
    var tip: Double
    var formatter: NumberFormatter
    
    private var splitTotal: Double {
        let totalWithTip = total + (total * tip / 100)
        return totalWithTip / Double(split)
    }
    
    private func incrementSplit() {
        if split < 20 {
            split += 1
        }
    }
    
    private func decrementSplit() {
        if split > 1 {
            split -= 1
        }
    }
    
    var body: some View {
        HStack {
            // left
            VStack(alignment: .leading) {
                Text("Split")
                    .foregroundColor(.primaryAccent)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                HStack {
                    Button(action: decrementSplit) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.primaryAccent)
                    }
                    
                    Text("\(split)")
                        .font(.title)
                        .foregroundColor(.primaryAccent)
                        .fontWeight(.bold)
                    
                    Button(action: incrementSplit) {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.primaryAccent)
                    }
                }
            }
            
            Spacer()
            
            // right
            VStack(alignment: .trailing) {
                Text("Split Total")
                    .foregroundColor(.primaryAccent)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text(formatter.string(from: NSNumber(value: splitTotal)) ?? "?0.00")
                    .font(.title)
                    .foregroundColor(.primaryAccent)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.secondaryAccent)
        )
    }
}

struct SplitView_Previews: PreviewProvider {
    static var f: NumberFormatter = {
        let f = NumberFormatter()
        f.maximumFractionDigits = 2
        f.numberStyle = .currency
        f.currencyCode = "USD"
        return f
    }()
    
    static var previews: some View {
        SplitView(total: 100, tip: 10, formatter: f)
    }
}
