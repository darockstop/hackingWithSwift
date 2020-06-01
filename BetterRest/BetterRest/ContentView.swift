//
//  ContentView.swift
//  BetterRest
//
//  Created by g rowan on 6/1/20.
//  Copyright © 2020 darockstop. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var cupsOfCoffee = 1
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    
    let alist = ["la", "la"]
    
    let model = SleepCalculator()
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a wake up time", selection:$wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
                }

                Stepper(value: $sleepAmount, in: 3...16, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                
//                Stepper(value: $cupsOfCoffee, in: 0 ... 20) {
//                    if (cupsOfCoffee == 1) {
//                        Text("\(cupsOfCoffee) cup")
//                    } else {
//                        Text("\(cupsOfCoffee) cups")
//                    }
//                }
                Picker("Cups of Coffee", selection: $cupsOfCoffee) {
                    ForEach(0 ..< 20) {
                        Text("\($0)")
                    }
                }
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                Button(action: calculateBedtime) {
                    Text("Calculate")
                }
            )
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func calculateBedtime() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(cupsOfCoffee))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            alertTitle = "Go to bed at"
            alertMessage = formatter.string(from: sleepTime)
            showingAlert = true
            
        } catch {
            alertTitle = "Error"
            alertMessage = "There was a problem calculating your bed time."
            showingAlert = true
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
