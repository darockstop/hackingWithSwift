//
//  ContentView.swift
//  WeSplit
//
//  Created by g rowan on 5/30/20.
//  Copyright © 2020 darockstop. All rights reserved.
//

import SwiftUI

enum VolumeUnit: Int, CaseIterable, Identifiable {
    case milliliters, liters, cups, pints, gallons
    
    var name: String {
        switch self {
        case .milliliters: return "ml"
        case .liters: return "liters"
        case .cups: return "cups"
        case .pints: return "pints"
        case .gallons: return "gallons"
        }
    }
    
    var inMilliliters: Double {
        switch self {
        case .milliliters: return 1
        case .liters: return 1e6
        case .cups: return 236_588
        case .pints: return 473_176
        case .gallons: return 3.785e6
        }
    }
    
    var id: VolumeUnit {self}
}

struct ContentView: View {
    @State private var amountEntered = ""
    @State private var unitIndex = 0
    @State private var reqUnitIndex = 0
    
    private var reqAmount: Double {
        let currUnit = VolumeUnit(rawValue: unitIndex)!
        let reqUnit = VolumeUnit(rawValue: reqUnitIndex)!
        let amount = Double(amountEntered) ?? 0
        return amount * currUnit.inMilliliters / reqUnit.inMilliliters
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $amountEntered)
                    Picker("Unit", selection: $unitIndex) {
                        ForEach(0 ..< VolumeUnit.allCases.count) {
                            Text(VolumeUnit(rawValue: $0)!.name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("\(reqAmount)")
                    Picker("Unit", selection: $reqUnitIndex) {
                        ForEach(0 ..< VolumeUnit.allCases.count) {
                            Text(VolumeUnit(rawValue: $0)!.name)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
        .navigationBarTitle("Volume Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
