//
//  EpisodesViewController.swift
//  rickAndMorty
//
//  Created by Ксения Шилина on 08.11.2023.
//

import UIKit

class EpisodesViewController: UIViewController {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
    
    var dataSourse: CollectionViewDataSourse?
    
    var sectionModel: [SectionModel] = [SectionModel(type: .withHeight(id: "LogoSection", height: 0.13, top: 0, bottom: 50), items: [CellType.logo(id: "1")])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bounds = UIScreen.main.bounds
        
        collectionView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        view.addSubview(collectionView)
        
        dataSourse = CollectionViewDataSourse(collectionView: collectionView)
        
        collectionView.backgroundColor = .white
        collectionView.register(LogoCollectionViewCell.self, forCellWithReuseIdentifier: "Logo")
        collectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: "Episode")
        
       // dataSourse?.reload(sectionModels: sectionModel)
        
        getEpisodes()
        
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
            let types = self.sectionModel.map { model in
                return model.type
            }
            
            let type = types[index]
            switch type {
            case let .withHeight(_ , height, top, bottom):
                return self.makeSection(height: height, top: top, bottom: bottom)
            }
        }
        
    }

    func getEpisodes() {
        let url = URL(string: "https://rickandmortyapi.com/api/episode")!
        URLSession.shared.dataTask(with: url) { data, response, errore in
            do {
                let value = try JSONDecoder().decode(EpisodesResults.self, from: data!).results
                let sectionModels = value.map { episode in
                    return SectionModel(type: .withHeight(id: "\(episode.id)", height: 0.45, top: 5, bottom: 5), items: [CellType.episode(id: "\(episode.id)", episode: episode)])
                }
                self.sectionModel.append(contentsOf: sectionModels)
                DispatchQueue.main.async {
                  
                    self.dataSourse?.reload(sectionModels: self.sectionModel)
                }
                
            } catch {
                print(error)
            }
           
        }.resume()
    }
    
}
