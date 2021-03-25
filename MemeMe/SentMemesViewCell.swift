//
//  SentMemesViewCell.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 21/03/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

// MARK: - MemeCollectionViewCell: UICollectionViewCell

class SentMemesViewCell: UICollectionViewCell {
    
    // var allMeme = [Meme]()
    
    // MARK: Outlets
    
    @IBOutlet weak var MemeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    func viewDidLoad() {
        print("viewDidLoad UICollectionViewCell")
        
        let space:CGFloat = 3.0
        //largura
        let dimension = (frame.size.width - (2 * space)) / 3.0
        //altura TODO
     //   let dimension2 = (frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
}
