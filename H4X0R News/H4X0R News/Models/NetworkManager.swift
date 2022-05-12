//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Gayathri Chelluri on 5/5/2022.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
            URLSession(configuration: .default).dataTask(with: url) { data, response, error in
                if let e = error {
                    print("Problem fetching data: \(e)")
                    return
                }
                
                if let safeData = data, let decodedData = self.parseJSON(data: safeData){
                    DispatchQueue.main.async {
                        self.posts = decodedData.hits
                    }
                }
            }.resume()
        }
    }
    
    func parseJSON(data: Data) -> PostsData? {
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(PostsData.self, from: data)
            return result
        } catch {
            print("Problem decoding data: \(error)")
            return nil
        }
        
    }
}
