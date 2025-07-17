//
//  NewsCell.swift
//  AutoDigest
//
//  Created by Антон Павлов on 17.07.2025.
//

import UIKit

final class NewsCell: UICollectionViewCell {
    
    // MARK: - Reuse Identifier
    
    static let reuseID = "NewsCell"
    
    // MARK: - UI Elements
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold, width: .expanded)
        label.textColor = .white
        label.numberOfLines = 3
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowRadius = 2
        label.layer.masksToBounds = false
        
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    func configure(with item: NewsItem) {
        titleLabel.text = item.title
        imageView.image = nil
        
        Task {
            if let url = URL(string: item.titleImageUrl),
               let (data, _) = try? await URLSession.shared.data(from: url),
               let image = UIImage(data: data) {
                imageView.alpha = 0
                imageView.image = image
                UIView.animate(withDuration: 0.3) {
                    self.imageView.alpha = 1
                }
            }
        }
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.cornerRadius = 16
        layer.masksToBounds = false
    }
    
    private func addElements() {
        [imageView,
         titleLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
