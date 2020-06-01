//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by g rowan on 5/31/20.
//  Copyright © 2020 darockstop. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswerIndex = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var attempts = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
//                        .foregroundColor(.white)
                    Text(countries[correctAnswerIndex])
                        .fontWeight(.black)
                        .titleStyle()
                        
                }
                
                ForEach(0 ..< 3) { index in
                    Button(action: {
                        self.checkResponse(index)
                    }) {
                        FlagImage(imageFileName: self.countries[index])
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score) out of \(attempts)"), dismissButton: .default(Text("Play Again")) {
                    self.resetGame()
                })
        }
    }
    
    func checkResponse(_ chosenIndex: Int) {
        attempts += 1
        if chosenIndex == correctAnswerIndex {
            score += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Incorrect, that is \(self.countries[chosenIndex])'s flag."
        }
        
        showingScore = true
    }
    
    func resetGame() {
        countries.shuffle()
        correctAnswerIndex = Int.random(in: 0...2)
    }
}

struct FlagImage: View {
    var imageFileName: String
    
    var body: some View {
        Image(imageFileName)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
//            .padding()
//            .background(Color.blue)
//            .clipShape(Capsule())
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
