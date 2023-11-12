//
//  EpisodeCollectionViewCell.swift
//  rickAndMorty
//
//  Created by Ксения Шилина on 09.11.2023.
//

import UIKit


class EpisodeCollectionViewCell: UICollectionViewCell {
    
    let episodeImage = UIImageView()
    let nameEpisodelabel = UILabel()
    let playEpisodeImage = UIImageView()
    let numberEpisodeLabel = UILabel()
    let cellBackGroundView = UIView()
    let likeButton = UIButton(type: .custom)
    
    var model: Episode!
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    required init?(coder: NSCoder) {
        fatalError("")
        
    }
    func setUp(episode: Episode) {
        self.model = episode
        if let url = episode.characters.randomElement() {
            getImage(url: url)
        }
        numberEpisodeLabel.text = episode.episode
        nameEpisodelabel.text = episode.name
        likeButton.isSelected = episode.like ?? false
    }
    
    func makeUI() {
        
        let bounds = contentView.bounds
        
        cellBackGroundView.backgroundColor = UIColor(named: "cellGray")
        cellBackGroundView.layer.cornerRadius = 10
        cellBackGroundView.frame = CGRect(x: 0, y: 286, width: bounds.width, height: 71)
        contentView.addSubview(cellBackGroundView)
        
        
        episodeImage.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 232)
        
        contentView.addSubview(episodeImage)
        
        playEpisodeImage.frame = CGRect(x: 0, y: 0, width: 33, height: 34)
        playEpisodeImage.center = CGPoint(x: 32, y: 35)
        playEpisodeImage.image = UIImage(named: "play")
        cellBackGroundView.addSubview(playEpisodeImage)
        
        let episodeImageXpos = bounds.width - 50
        
        
        likeButton.frame = CGRect(x: episodeImageXpos, y: 0, width: 41, height: 36)
        likeButton.center.y = 35
        
        let normalHeartImage = createHeartImage(color: UIColor(named: "heartColor") ?? .gray)
                likeButton.setImage(normalHeartImage, for: .normal)
        
        let selectedHeartImage = createHeartImage(color: .red)
                likeButton.setImage(selectedHeartImage, for: .selected)
                
                likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
                cellBackGroundView.addSubview(likeButton)
        
       
        
        nameEpisodelabel.frame = CGRect(x: 12, y: 235, width: bounds.width, height: 54)
        nameEpisodelabel.text = "Rick Sanchez"
        contentView.addSubview(nameEpisodelabel)
        nameEpisodelabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        numberEpisodeLabel.frame = CGRect(x: 0, y: 0, width: 157, height: 23)
        numberEpisodeLabel.center = CGPoint(x: (bounds.width - 25)/2, y: 35)
        numberEpisodeLabel.text = "Pilot"
        cellBackGroundView.addSubview(numberEpisodeLabel)
        numberEpisodeLabel.font = .systemFont(ofSize: 16, weight: .regular)
    }
    func createHeartImage(color: UIColor) -> UIImage {
        
        var imageName: String
        if color == .red {
            imageName = "heart.fill"
        } else {
            imageName = "heart"
        }
        
            let heartConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
            let heartImage = UIImage(systemName: imageName, withConfiguration: heartConfiguration)
            let coloredHeartImage = heartImage?.withTintColor(color, renderingMode: .alwaysOriginal)
            return coloredHeartImage ?? UIImage()
        }
    
    func getImage(url: String) {
        let url = URL(string: url)!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            do {
                let value = try JSONDecoder().decode(Character.self, from: data ?? .init())
                
                
                self.image(imageURL: value.image)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    func image(imageURL: String) {
        URLSession.shared.dataTask(with: URL(string: imageURL)!) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self.episodeImage.image = UIImage(data: data)
                }
               
            }
        }.resume()
    }
    @objc func likeButtonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.likeButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.likeButton.transform = .identity
            }
        })
        
        likeButton.isSelected = !self.likeButton.isSelected
        if likeButton.isSelected {
            Favourites.shared.episodes.append(model)
        } else {
            Favourites.shared.episodes.removeAll(where: { $0.id == self.model.id })
        }
        
    }
}
