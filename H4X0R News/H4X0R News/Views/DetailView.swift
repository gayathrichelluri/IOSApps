//
//  SwiftUIView.swift
//  H4X0R News
//
//  Created by Gayathri Chelluri on 5/5/2022.
//

import SwiftUI
import WebKit

struct DetailView: View {
    
    var url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.netflix.com/browse")
    }
}
