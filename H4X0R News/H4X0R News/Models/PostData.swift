//
//  PostData.swift
//  H4X0R News
//
//  Created by Gayathri Chelluri on 5/5/2022.
//

import Foundation

struct PostsData: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
}
