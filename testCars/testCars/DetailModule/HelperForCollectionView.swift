//
//  HelperForCollectionView.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import UIKit

class HelperForCollectionView: NSObject {
    var sections: [ListSection] = []
    
    let identifierForMini = "MiniCollectViewCell"
    let identifierForButtons = "CellForButtons"

    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex]
            switch section {
            case .menuScrollMini(_):
                return self?.createMiniSection()
            case .buttons(_):
                return self?.createButtonsSection()
            case .none:
                return nil
            }
        }
    }
    
    func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    func createMiniSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 0,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    func createButtonsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1)), subitems: [item])
        group.interItemSpacing = .flexible(10)
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}

extension HelperForCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
        case .menuScrollMini(let menuMini):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierForMini, for: indexPath) as? CellForUserInfo
                    
            else {
                return UICollectionViewCell()
            }

            cell.configurateCell(imageCarName: menuMini[indexPath.row].imageCarString,
                                 mainTitleLabelText: "\(menuMini[indexPath.row].nameOfCar ) \(menuMini[indexPath.row].modelName) \(menuMini[indexPath.row].transmissionName) \(menuMini[indexPath.row].year)",
                                 nameLabelText: menuMini[indexPath.row].nameOfCar,
                                 mainInfoText: "\(menuMini[indexPath.row].power) \(menuMini[indexPath.row].transmissionName) \(menuMini[indexPath.row].year)",
                                 nameOfOwnerText: "Test",
                                 photoOfOwnerText: "Test")
            return cell
            
        case .buttons(let menuButtons):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierForButtons, for: indexPath) as? CellForComments
                    
            else {
                return UICollectionViewCell()
            }

            cell.configurateCell(imageName: menuButtons[indexPath.row].nameOfOwner, labelText: "Test")
            return cell
        }
    }
}
