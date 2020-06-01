// From Hacking with Swift TwoStraws

//
//  ContentView.swift
//  WeSplit
//
//  Created by g rowan on 5/30/20.
//  Copyright © 2020 darockstop. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var enteredAmount = ""  // We must use a string to store a text field value
    @State private var numPeopleIndex = 0
    @State private var tipIndex = 2
    private let tips = [0, 10, 15, 20, 25]
    
    var totalAmount: Double {
        let tip = Double(tips[tipIndex])
        let amount = Double(enteredAmount) ?? 0
        return amount + tip/100 * amount
    }
    
    var totalPerPerson: Double {
        let numPeople = Double(numPeopleIndex + 2)
        let tip = Double(tips[tipIndex])
        let amount = Double(enteredAmount) ?? 0
        
        let grandTotal = amount + tip/100 * amount
        return grandTotal / numPeople
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $enteredAmount)  // when creating TextField in form first argument is placeholder and second is a two-way bound var
                    .keyboardType(.decimalPad)  // shows a number keypad by default
                    
                    Picker("Number of people", selection: $numPeopleIndex) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("Tip")) {
                    Picker("Tip", selection: $tipIndex) {
                        ForEach(0 ..< tips.count) {
                            Text("\(self.tips[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total with Tip")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                        .foregroundColor(tipIndex == 0 ? Color.red : Color.primary)
                }
                
                Section(header: Text("Total per Person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
            }
            .navigationBarTitle("WeSplit")  // is always attached to the thing inside NavigationView because it allows iOS to change titles freely as different views go in and out of the NavigationView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
