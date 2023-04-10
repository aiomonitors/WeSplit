//
//  ContentView.swift
//  WeSplit
//
//  Created by Shihab Chowdhury on 4/9/23.
//

import SwiftUI

extension Double {
    func getRoundedString() -> String {
        String(format: "%.2f", ceil(self * 100)/100)
    }
}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    // Specifically meant to store input focus
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [16, 18, 20, 22, 24]
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    var tipValue: Double {
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        return tipValue
    }
    
    var checkAmountWithTip: Double {
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = checkAmountWithTip / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                } header: {
                    Text("Total per person")
                }
                
                Section {
                    HStack {
                        Text("Original Amount")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(checkAmount.getRoundedString())")
                    }
                    
                    HStack {
                        Text("Tip Amount")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(tipValue.getRoundedString())")
                    }
                    
                    HStack {
                        Text("Grand Total")
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("\(checkAmountWithTip.getRoundedString())")
                            .tint(.blue)
                    }
                } header: {
                    Text("Check Breakdown")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                    .tint(.pink)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
