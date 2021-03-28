//
//  MemeListViewController.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 20/03/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var MemeTableView: UITableView!
    
    var allMeme = [Meme]()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
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
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        super.viewWillAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCollectionViewCell") as! MemeCollectionViewCell
        let meme = self.allMeme[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.MemeImageView.image = meme.memedUIImage
        cell.topLabel.text = meme.top.description
        cell.BottomLabel.text = meme.bottom.description
        
        tableView.rowHeight = 96
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Aqui no meme collection list didSelectRowAt")
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailsViewController
        detailController.meme = self.allMeme[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
