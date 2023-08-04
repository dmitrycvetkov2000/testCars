//
//  HelperForCollectionView.swift
//  testCars
//
//  Created by Дмитрий Цветков on 03.08.2023.
//

import UIKit

class HelperForCollectionView: NSObject {
    weak var view: DetailVC?
    var viewModel: DetailViewModelProtocol?
    
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
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 0,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        return section
    }
    
    func createButtonsSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.48), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item])
        group.interItemSpacing = .flexible(2)
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
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
                                 nameLabelText: "\(menuMini[indexPath.row].nameOfCar ) \(menuMini[indexPath.row].modelName)",
                                 mainInfoText: "\(menuMini[indexPath.row].power) \(menuMini[indexPath.row].transmissionName) \(menuMini[indexPath.row].year)",
                                 nameOfOwnerText: menuMini[indexPath.row].nameOfOwner,
                                 photoOfOwnerText: menuMini[indexPath.row].imageOfOwner)
            return cell
            
        case .buttons(let menuButtons):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierForButtons, for: indexPath) as? CellForComments
                    
            else {
                return UICollectionViewCell()
            }

            cell.configurateCell(imageName: menuButtons[indexPath.row].photoMain, dateText: menuButtons[indexPath.row].dateText, commentText: menuButtons[indexPath.row].commentText, numberOfLikes: menuButtons[indexPath.row].numberOfLikes, numberOfComments: menuButtons[indexPath.row].numberOfComments)
            return cell
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height) {
            view?.beginBathFetch()
        }
    }
}
