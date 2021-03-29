//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 20/03/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    var allMeme = [Meme]()
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillApper")
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
        allMeme = appDelegate.memes
        
        collectionView!.reloadData()
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            print("viewDidLoad Collection")
    
            let space:CGFloat = 3.0
            //largurass
            let dimension = (view.frame.size.width - (2 * space)) / 3.0
            //altura TODO
              //  let dimension2 = (view.frame.size.height - (2 * space)) / 3.0
    
                flowLayout.minimumInteritemSpacing = space
                flowLayout.minimumLineSpacing = space
                flowLayout.itemSize = CGSize(width: dimension, height: dimension)
                print(CGSize(width: dimension, height: dimension))
        //
            }
    
//    let margin: CGFloat = 3
//    let cellsPerRow = 3
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        guard let collectionView = collectionView, let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
//
//        flowLayout.minimumInteritemSpacing = margin
//        print(flowLayout.minimumInteritemSpacing = margin)
//
//        flowLayout.minimumLineSpacing = margin
//        print(margin)
//
//        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
//        print(flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
//
//        collectionView.contentInsetAdjustmentBehavior = .always
//        //   collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SentMemesViewCell")
//    }
//
//    override func viewWillLayoutSubviews() {
//        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
//        let marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
//        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
//        flowLayout.itemSize =  CGSize(width: itemWidth, height: itemWidth)
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewDidAppear Collection")
        collectionView!.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allMeme.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesViewCell", for: indexPath) as! SentMemesViewCell
        let meme = self.allMeme[(indexPath as NSIndexPath).row]
        
        // Set the image
        cell.MemeImageView.image = meme.memedUIImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        print("Aqui no meme collection list didSelectRowAt")
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailsViewController
        detailController.meme = self.allMeme[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
