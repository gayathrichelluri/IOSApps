//
//  ContentView.swift
//  Dicee-Swift
//
//  Created by Gayathri Chelluri on 5/5/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var leftDiceNumber: Int = 1
    @State var rightDiceNumber: Int = 1
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 150.0) {
                Image("diceeLogo")
                HStack {
                    DiceView(n: leftDiceNumber)
                    DiceView(n: rightDiceNumber)
                }
                Button(action: {
                    leftDiceNumber = Int.random(in: 1...6)
                    rightDiceNumber = Int.random(in: 1...6)
                }) {
                    Text("Roll")
                        .font(.system(size: 25))
                        .bold()
                        .padding(.all)
                        .foregroundColor(.white)
                }.frame(width: 100)
                    .background(Color(red: 0.608, green: 0.111, blue: 0.119))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 3))
            }
        }
        
    }
}

struct DiceView: View {
    var n: Int
    
    var body: some View {
        Image("dice\(n)")
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 3))
            .padding(.horizontal)
            
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
