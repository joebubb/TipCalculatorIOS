//
//  KeyboardView.swift
//  TipCalculator
//
//  Created by Joseph Bubb on 8/14/22.
//

import SwiftUI

struct KeyboardView: View {
    @Binding var text: String
    var fractionalDigitsAllowed: Int
    
    var body: some View {
        VStack {
            HStack {
                key(1)
                key(2)
                key(3)
            }
            
            HStack {
                key(4)
                key(5)
                key(6)
            }
            
            HStack {
                key(7)
                key(8)
                key(9)
            }
            
            HStack {
                decimalKey
                key(0)
                backspace
            }
            
            clear
        }
    }
    
    private func key(_ number: Int) -> some View {
        Button(action: keyAction(number)) {
            Text("\(number)")
                .frame(width: keyWidth, height: keyHeight)
                .foregroundColor(.primaryAccent)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondaryAccent)
                )
        }
    }
    
    private func keyAction(_ number: Int) -> () -> () {
        {
            if digitsAfterDecimal(string: text) < Double(fractionalDigitsAllowed) {
                text += "\(number)"
            }
        }
    }
    
    private func digitsAfterDecimal(string: String) -> Double {
        let decimalIndex = string.firstIndex(of: ".")
        
        if let i = decimalIndex {
            return Double(string.suffix(from: i).count - 1)
        }
        
        return -Double.infinity
    }
    
    var decimalKey: some View {
        Button(action: {
            if fractionalDigitsAllowed > 0 && !text.contains(".") {
                if text == "" {
                    text += "0"
                }
                text += "."
            }
        } ) {
            Text(".")
                .frame(width: keyWidth, height: keyHeight)
                .foregroundColor(.primaryAccent)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondaryAccent)
                )
        }
    }
    
    var backspace: some View {
        func delete(text: String) -> String {
            var result = ""
            
            if text.count > 0 {
                result = String(text.prefix(text.count - 1))
            }
             
            return result
        }
        
        return Button(action: { text = delete(text: text)} ) {
            Image(systemName: "delete.left")
                .frame(width: keyWidth, height: keyHeight)
                .foregroundColor(.primaryAccent)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondaryAccent)
                )
        }
    }
    
    var clear: some View {
        Button(action: { text = "" }) {
            Text("Clear")
                .frame(width: keyWidth * 2, height: keyHeight)
                .foregroundColor(.primaryAccent)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondaryAccent)
                )
        }
    }
    
    var keyWidth: CGFloat {
        (UIScreen.main.bounds.width - 48) / 3
    }
    
    var keyHeight: CGFloat {
        keyWidth / 2
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(text: .constant(""), fractionalDigitsAllowed: 2)
    }
}
