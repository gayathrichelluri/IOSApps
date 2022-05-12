//
//  InfoView.swift
//  G3Card
//
//  Created by Gayathri Chelluri on 5/5/2022.
//

import SwiftUI

struct InfoView: View {
    var text: String
    var imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.white)
            .frame(height: 50)
            .overlay(HStack {
                Image(systemName: imageName)
                    .foregroundColor(.green)
                Text(text)
                    .font(.system(size: 20))
                    .bold()
            })
            .padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Hello", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}

