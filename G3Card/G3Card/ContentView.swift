//
//  ContentView.swift
//  G3Card
//
//  Created by Gayathri Chelluri on 5/5/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.09, green: 0.63, blue: 0.52, opacity: 1.00)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0.0) {
                Image("g3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                Text(" Gayathri Chelluri ")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .bold()
                    .foregroundColor(.white)
                Text("Full Stack Developer")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .bold()
                Divider()
                InfoView(text: "+61 470640241", imageName: "phone.fill")
                InfoView(text: "gchelluri@palo-it.com", imageName: "envelope.fill")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}

// I deleted some assets and so the build is failing...
