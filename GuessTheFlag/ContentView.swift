//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jesse Russell on 23/6/20.
//  Copyright © 2020 Jesse Russell. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var imagesName: String
    
    var body: some View {
        Image(imagesName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(imagesName: self.countries[number])
                    }
                }
                VStack{
                    Text("Your Score: \(score)")
                        .foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.callout)
                }
                Button(action: {
                    self.score = 0
                }) {
                    Text("Reset Score")
                        .fontWeight(.black)
                        .font(.subheadline)
                        .padding(10)
                        .background(Color.red)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "That is Correct!"
            score += 1
        } else {
            scoreTitle = "Not quite. \(countries[number]) has that flag."
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
