//
//  NewsService.swift
//  AutoDigest
//
//  Created by Антон Павлов on 16.07.2025.
//

import Foundation

// MARK: - Protocol

protocol NewsServiceProtocol {
    func fetchNews(page: Int, limit: Int) async throws -> [NewsItem]
}

final class NewsService: NewsServiceProtocol {
    
    // MARK: - Public Methods
    
    func fetchNews(page: Int, limit: Int) async throws -> [NewsItem] {
        let urlString = "https://webapi.autodoc.ru/api/news/\(page)/\(limit)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let responseData = try decoder.decode(NewsResponse.self, from: data)
        return responseData.news
    }
}
