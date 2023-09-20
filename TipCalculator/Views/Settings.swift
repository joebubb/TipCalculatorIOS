import SwiftUI

struct Settings: View {
    @Binding var selectedCurrency: Currency
    @Binding var sheetShowing: Bool
    let currencies = Currency.supportedCurrencies.map { Currency(code: $0) }

    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(currencies) { currency in
                    Button {
                        selectedCurrency = currency
                        sheetShowing.toggle()
                    } label: {
                        HStack {
                            Text("\(currency.symbol) (\(currency.code))")
                                .foregroundColor(.primaryAccent)
                            
                            if currency == selectedCurrency {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.primaryAccent)
                            }
                        }
                    }
                    .listRowBackground(Color.secondaryAccent)
                }
            }
            .navigationTitle("Currencies")
            .navigationBarTitleTextColor(.primaryAccent)
            Spacer()
        }
    }
}



struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(selectedCurrency: .constant(Currency(code: "USD")), sheetShowing: .constant(true))
    }
}
