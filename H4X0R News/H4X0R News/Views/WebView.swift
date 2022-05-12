//
//  WebView.swift
//  H4X0R News
//
//  Created by Gayathri Chelluri on 5/5/2022.
//

import Foundation
import SwiftUI
import WebKit

//Loads up website to show the content for the url requested
struct WebView: UIViewRepresentable {
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                uiView.load(URLRequest(url: url))
            }
        }
    }
    
}
