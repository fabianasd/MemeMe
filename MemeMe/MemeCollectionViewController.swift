//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 20/03/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets
    @IBOutlet var MemeTableView: UITableView!
    
    var allMeme = [Meme]()
    var memeCollectionViewCellLabel: String = "MemeCollectionViewCell"
    var memeDetailViewControllerLabel: String = "MemeDetailViewController"
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
        allMeme = appDelegate.memes
        
        MemeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allMeme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: memeCollectionViewCellLabel) as! MemeCollectionViewCell
        let meme = self.allMeme[(indexPath as NSIndexPath).row]
        
        cell.MemeImageView.image = meme.memedUIImage
        cell.topLabel.text = meme.top.description
        cell.BottomLabel.text = meme.bottom.description
        
        tableView.rowHeight = 96
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: memeDetailViewControllerLabel) as! MemeDetailsViewController
        detailController.meme = self.allMeme[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
