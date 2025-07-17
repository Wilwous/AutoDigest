//
//  NewItem.swift
//  AutoDigest
//
//  Created by Антон Павлов on 16.07.2025.
//

import Foundation

struct NewsItem: Decodable, Hashable {
    let id: Int
    let title: String
    let description: String
    let publishedDate: String
    let url: String
    let fullUrl: String
    let titleImageUrl: String
    let categoryType: String
}
