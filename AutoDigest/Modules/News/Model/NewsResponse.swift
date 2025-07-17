//
//  NewsResponse.swift
//  AutoDigest
//
//  Created by Антон Павлов on 16.07.2025.
//

import Foundation

struct NewsResponse: Decodable {
    let news: [NewsItem]
    let totalCount: Int
}
