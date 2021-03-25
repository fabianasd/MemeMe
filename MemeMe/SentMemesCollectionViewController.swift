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
        cell.nameLabel.text = meme.top.description
        cell.MemeImageView?.image = meme.originalImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeCollectionViewCell") as! ViewController
        detailController.memedImage = self.allMeme[(indexPath as NSIndexPath).row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
