import SwiftUI

struct ContentView: View {
    @State var billTotal = ""
    @State var tip = ""
    @State var currency = Currency(code: "USD")
    @State var settingsShowing = false
    @State private var selected = Fields.bill
    @Environment(\.colorScheme) var colorScheme
    
    enum Fields {
        case bill, tip
    }
    
    var body: some View {
        VStack {
            // Settings Button
            HStack {
                Spacer()
                Button(action: {
                    settingsShowing.toggle()
                }) {
                    Image(systemName: "gearshape")
                        .font(.title)
                }
                .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            // Bill Total
            BillField(currency: currency, billTotal: billTotal, selected: selected == Fields.bill)
                .onTapGesture {
                    selected = Fields.bill
                }
            
            // Tip Percentage
            TipField(tip: tip, selected: selected == Fields.tip)
                .onTapGesture {
                    selected = Fields.tip
                }
            
            // Split
            SplitView(total: Double(billTotal) ?? 0, tip: Double(tip) ?? 0, formatter: currency.formatter)
            
            // Keyboard
            Spacer()
            
            switch selected {
                case .bill:
                    KeyboardView(text: $billTotal, fractionalDigitsAllowed: currency.decimalDigitsAllowed)
                case .tip:
                    KeyboardView(text: $tip, fractionalDigitsAllowed: 0)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom)
        .sheet(isPresented: $settingsShowing, onDismiss: { billTotal = "" }) {
            Settings(selectedCurrency: $currency, sheetShowing: $settingsShowing)
                .preferredColorScheme(colorScheme)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
