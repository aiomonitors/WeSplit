//
//  ContentView.swift
//  WeSplit
//
//  Created by Shihab Chowdhury on 4/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
            }
            
            Section {
                Text(checkAmount, format: .currency(code: currencyCode))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
