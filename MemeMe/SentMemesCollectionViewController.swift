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
        
//        let space:CGFloat = 20.0
//        //largura
//        let dimension = (view.frame.size.width - (2 * space)) / 3.0
//        //altura TODO
//        let dimension2 = (view.frame.size.height - (2 * space)) / 3.0
//
   //     flowLayout.minimumInteritemSpacing = 2
//        print("1")
//        print(space)
//        //espaco entre linhas
  //      flowLayout.minimumLineSpacing = 2
//        print("2")
//        print(space)
        //tamanho da celula
    //    flowLayout.itemSize = CGSize(width: 140, height: 124)
//        print("3")
//        print(CGSize(width: dimension, height: dimension))
        
    }
    
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
        
        // Set the name and image
        cell.MemeImageView.image = meme.memedUIImage
                
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        print("Aqui no meme collection list didSelectRowAt")
        //  var memeDetails = self.allMeme[indexPath.row]
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailsViewController
        detailController.meme = self.allMeme[(indexPath as NSIndexPath).row]
        //   detailController.meme = memeDetails
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
