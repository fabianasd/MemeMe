//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Gabriel Petrovick on 20/03/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

    var memes: [Meme]! {
              let object = UIApplication.shared.delegate
              let appDegate = object as! AppDelegate
              return appDegate.memes
          }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        //largura
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        //altura TODO
        //let dimension = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
}
