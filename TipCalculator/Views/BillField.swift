import SwiftUI

struct BillField: View {
    var currency: Currency
    var billTotal: String
    var selected: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var billAsDouble: Double? {
        Double(billTotal) ?? nil
    }
    
    var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var ColorFormattedBill: Text {
        // this computed property adds color to the formatted bill so the user knows
        // what they typed and didn't type 
        
        // a default text view to return if nothing gets typed into the bill field
        // this is a completely gray view formatted for the selected currency
        if billTotal == "" {
            let string = currency.formatter.string(from: NSNumber(value: 0))!
            return Text(string)
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.bold)
        }
        
        let formattedString = currency.formatter.string(from: NSNumber(value: billAsDouble!))!
        
        // if the currency does not allow decimals then no gray is necessary, given that something was typed
        if currency.decimalDigitsAllowed == 0 {
            return Text(formattedString)
                .foregroundColor(textColor)
                .font(.title)
                .fontWeight(.bold)
        }
        
        // if there is a decimal in the formatted string there will always be two parts
        // we split around the decimal
        let wholePart = formattedString.split(separator: ".")[0]
        let fractionalPart = formattedString.split(separator: ".")[1]
        
        // the whole part will never be gray is something was typed
        let left = Text(wholePart)
            .foregroundColor(textColor)
            .font(.title)
            .fontWeight(.bold)
        
        // if the decimal was typed color it
        if billTotal.contains(".") {
            let middle = Text(".")
                .foregroundColor(textColor)
                .font(.title)
                .fontWeight(.bold)
            
            // see how many digits after the decimal the user actually typed
            // some digits could have been added by the formatter, which should be gray
            let decimalIndex = billTotal.firstIndex(of: ".")!
            let typedDigitsAfterDecimal = billTotal.count - billTotal[...decimalIndex].count
            var right: Text
            
            // if the user did type digits after the decimal, color those
            if typedDigitsAfterDecimal > 0 {
                // color what was typed
                let colorPart = fractionalPart.prefix(typedDigitsAfterDecimal)
                
                // don't color anything that wasn't actually typed
                let grayPart = fractionalPart.suffix(fractionalPart.count - typedDigitsAfterDecimal)
                right = (Text(colorPart).foregroundColor(textColor) + Text(grayPart).foregroundColor(.gray))
                    .font(.title)
                    .fontWeight(.bold)

                return left + middle + right
                    
            } else {
                // else just make all decimal digits gray
                right = Text(fractionalPart)
                    .foregroundColor(.gray)
                    .font(.title)
                    .fontWeight(.bold)

                return left + middle + right
            }
                
        } else { // else, we know that both the decimal AND the fractional part should be gray
            let middle = Text(".")
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.bold)
            
            let right = Text(fractionalPart)
                .foregroundColor(.gray)
                .font(.title)
                .fontWeight(.bold)
            
            return left + middle + right
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Bill Total")
                    .foregroundColor(.gray)
                    .font(.headline)
                
                Spacer()
            }
            
            ColorFormattedBill.lineLimit(1)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder()
                .foregroundColor(selected ? .primaryAccent : .clear)
        )
    }
}

struct BillField_Previews: PreviewProvider {
    static var c = Currency(code: "USD")
    
    static var previews: some View {
        BillField(currency: c, billTotal: "1000.5", selected: true)
    }
}
