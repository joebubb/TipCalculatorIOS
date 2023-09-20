import Foundation

struct Currency: Identifiable, Equatable {
    var id = UUID()
    var code: String
    static let supportedCurrencies = ["USD", "EUR", "GBP", "JPY", "INR", "CNY", "RUB"]//.sorted()
    
    var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = code
        f.maximumFractionDigits = decimalDigitsAllowed
        return f
    }
    
    var decimalDigitsAllowed: Int {
        switch code {
            case "JPY":
                return 0
            default:
                return 2
        }
    }
    
    var symbol: String {
        formatter.currencySymbol
    }
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.code == rhs.code
    }
}
