//
//  ContentView.swift
//  I Am Rich - SwiftUI
//
//  Created by Gayathri Chelluri on 5/5/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color(UIColor(Color(hue: 0.553, saturation: 0.968, brightness: 0.633)))
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("I Am Rich")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 200.0, alignment: .center)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
