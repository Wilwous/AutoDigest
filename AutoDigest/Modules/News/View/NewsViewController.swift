//
//  ViewController.swift
//  AutoDigest
//
//  Created by Антон Павлов on 15.07.2025.
//

import UIKit
import Combine

final class NewsViewController: UIViewController {
    
    // MARK: - Public Properties
    
    private let viewModel = NewsViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: UICollectionViewDiffableDataSource<Int, NewsItem>!
    
    // MARK: - UI Elements
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: NewsLayoutProvider.createLayout()
        )
        view.backgroundColor = .systemBackground
        view.register(
            NewsCell.self,
            forCellWithReuseIdentifier: NewsCell.reuseID
        )
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addElements()
        setupLayoutConstraint()
        configureDataSource()
        bindViewModel()
        loadInitialNews()
    }
    
    // MARK: - Setup UI
    
    private func addElements() {
        [collectionView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupLayoutConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - ViewModel Binding
    
    private func bindViewModel() {
        viewModel.$news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.applySnapshot(with: items)
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                let fullMessage = """
                Не удалось загрузить новости.
                \(error)
                """
                self?.showAlert(title: "Что-то пошло не так", message: fullMessage)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Data Source
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, NewsItem>(
            collectionView: collectionView
        ) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewsCell.reuseID,
                for: indexPath
            ) as? NewsCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(with: item)
            return cell
        }
    }
    
    // MARK: - Snapshot
    
    private func applySnapshot(with items: [NewsItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NewsItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Data Loading
    
    private func loadInitialNews() {
        Task {
            await viewModel.fetchInitialNews()
        }
    }
}
