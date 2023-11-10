//
//  FavouritesEpisodesViewController.swift
//  rickAndMorty
//
//  Created by Ксения Шилина on 09.11.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
    
    var dataSourse: CollectionViewDataSourse?
    
    var sectionModels: [SectionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let models = Favourites.shared.episodes.map { episode in
            return SectionModel(type: .withHeight(id: "\(episode.id)", height: 0.45, top: 5, bottom: 5), items: [CellType.episode(id: "\(episode.id)", episode: .init(id: episode.id, name: episode.name, episode: episode.episode, url: episode.url, like: true, characters: episode.characters))])
        }
        self.sectionModels = models
        dataSourse?.reload(sectionModels: sectionModels)
    }
    
     func configureUI() {
        view.backgroundColor = .white
         
         let bounds = UIScreen.main.bounds
        
         collectionView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
         
         view.addSubview(collectionView)
         
         collectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: "Episode")
         
         dataSourse = CollectionViewDataSourse(collectionView: collectionView)
         dataSourse?.reload(sectionModels: sectionModels)
         
    }
    func makeSection(height: CGFloat, top: CGFloat, bottom: CGFloat) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(height)), subitems: [item])
        
        group.contentInsets = .init(top: 0, leading: 24, bottom: 0, trailing: 24)
                                            
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: top, leading: 0, bottom: bottom, trailing: 0)
        return section
        
        
    }

    func makeLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { index, _ in
            let types = self.sectionModels.map { model in
                return model.type
            }
            
            let type = types[index]
            switch type {
            case let .withHeight(_ , height, top, bottom):
                return self.makeSection(height: height, top: top, bottom: bottom)
            }
        }
        
    }
   
    }


