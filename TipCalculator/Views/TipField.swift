import SwiftUI

struct TipField: View {
    @Environment(\.colorScheme) var colorScheme
    
    var textColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var percentFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.maximumFractionDigits = 2
        return f
    }()
    
    var tip: String
    var selected: Bool
    
    var tipAsDouble: Double {
        let n = Double(tip)
        
        if nil == n {
            return 0
        }
        
        return n! / 100
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Tip")
                    .foregroundColor(.gray)
                    .font(.headline)
                
                Spacer()
            }
            
            Text(percentFormatter.string(from: NSNumber(value: tipAsDouble)) ?? "?%")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(tip.count > 0 ? textColor : .gray)
                .lineLimit(1)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
            .strokeBorder()
            .foregroundColor(selected ? .primaryAccent : .clear)
        )
    }
}

struct TipField_Previews: PreviewProvider {
    static var f: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.maximumFractionDigits = 2
        return f
    }()
    
    static var previews: some View {
        TipField(percentFormatter: f, tip: "10", selected: true)
    }
}
