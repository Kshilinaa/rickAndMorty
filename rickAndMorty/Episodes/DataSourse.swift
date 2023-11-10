//
//  DataSourse.swift
//  rickAndMorty
//
//  Created by Ксения Шилина on 08.11.2023.
//

import UIKit

enum SectionType: Hashable {
    var id: String {
        switch self {
        case let .withHeight(id , _, _, _) :
            return "sectionId_\(id)"
        }
    }
    case withHeight(id: String, height: CGFloat, top: CGFloat, bottom: CGFloat)
    static func == (lhs: SectionType, rhs: SectionType) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum CellType: Hashable {
    case logo(id: String)
    case filter(id: String)
    case episode(id: String, episode: Episode)
    static func == (lhs: CellType, rhs: CellType) -> Bool {
        lhs.id == rhs.id
    }
    var id: String {
        switch self {
        case let .episode(id, _):
            return "episodeCellId_\(id)"
        case let .filter(id):
            return "filterCellId_\(id)"
        case let .logo(id):
            return "logoCellId_\(id)"
            
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SectionModel {
    let type: SectionType
    let items: [CellType]
}

class CollectionViewDataSourse: UICollectionViewDiffableDataSource<SectionType, CellType> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .logo:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Logo", for: indexPath) as! LogoCollectionViewCell
                return cell
            case let .episode(_, episode):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Episode", for: indexPath) as! EpisodeCollectionViewCell
                cell.setUp(episode: episode )
                return cell
            case .filter:
                return UICollectionViewCell()
            }
        }
    }
    
    func reload(sectionModels: [SectionModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, CellType>()
        let types = sectionModels.map { $0.type }
        snapshot.appendSections(types)
        for model in sectionModels {
            snapshot.appendItems(model.items, toSection: model.type)
        }
       
        
        apply(snapshot, animatingDifferences: true)
    }
}


