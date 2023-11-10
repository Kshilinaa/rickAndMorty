//
//  LogoCollectionViewCell.swift
//  rickAndMorty
//
//  Created by Ксения Шилина on 09.11.2023.
//

import UIKit

class LogoCollectionViewCell: UICollectionViewCell {
    
    let logo = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI() {
        logo.frame = contentView.frame
        logo.image = UIImage(named: "nameR&M")
        contentView.addSubview(logo)
    }
}
