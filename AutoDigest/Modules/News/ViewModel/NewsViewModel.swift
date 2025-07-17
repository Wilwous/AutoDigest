//
//  NewsViewModel.swift
//  AutoDigest
//
//  Created by Антон Павлов on 16.07.2025.
//

import Foundation
import Combine

@MainActor
final class NewsViewModel: ObservableObject {
    
    // MARK: - Published State
    
    @Published private(set) var news: [NewsItem] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Private Properties
    
    private let newsService: NewsServiceProtocol
    private var currentPage = 1
    private let itemsPerPage = 15
    private var canLoadMore = true
    
    // MARK: - Initializers
    
    init(newsService: NewsServiceProtocol = NewsService()) {
        self.newsService = newsService
    }

    // MARK: - Public Methods
    
    func fetchInitialNews() async {
        currentPage = 1
        canLoadMore = true
        news.removeAll()
        await fetchNews()
    }

    func fetchMoreIfNeeded(currentItem: NewsItem?) async {
        guard let currentItem = currentItem else { return }
        let thresholdIndex = news.index(news.endIndex, offsetBy: -5)
        if news.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            await fetchNews()
        }
    }

    // MARK: - Private Methods
    
    private func fetchNews() async {
        guard !isLoading, canLoadMore else { return }
        isLoading = true
        do {
            let newItems = try await newsService.fetchNews(
                page: currentPage,
                limit: itemsPerPage
            )
            if newItems.isEmpty {
                canLoadMore = false
            } else {
                news += newItems
                currentPage += 1
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
