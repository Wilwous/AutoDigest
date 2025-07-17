//
//  NewsLayoutProvider..swift
//  AutoDigest
//
//  Created by Антон Павлов on 17.07.2025.
//

import UIKit

enum NewsLayoutProvider {
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { _, environment in
            let section = generateNewsSectionLayout(environment: environment)
            let maxWidth: CGFloat = 780
            let containerWidth = environment.container.effectiveContentSize.width

            if containerWidth > maxWidth {
                let inset = (containerWidth - maxWidth) / 2
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: inset, bottom: 0, trailing: inset)
            } else {
                section.contentInsets = NSDirectionalEdgeInsets.zero
            }

            return section
        }
    }

    private static func generateNewsSectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var groupItems: [NSCollectionLayoutGroup] = []

        for index in 0..<100 {
            if index % 5 == 0 {
                let featuredItem = createItem(width: 1.0, height: 300)
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: featuredItem.layoutSize,
                    subitems: [featuredItem]
                )
                groupItems.append(group)
            } else {
                let smallItem = createItem(width: 0.5, height: 220)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(220)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [smallItem, smallItem]
                )
                groupItems.append(group)
            }
        }

        let fullGroupHeight = CGFloat(groupItems.count) * 240
        let fullGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(fullGroupHeight)
        )

        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: fullGroupSize,
            subitems: groupItems
        )

        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.interGroupSpacing = 16
        return section
    }

    private static func createItem(width: CGFloat, height: CGFloat) -> NSCollectionLayoutItem {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(width),
            heightDimension: .absolute(height)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        return item
    }
}
