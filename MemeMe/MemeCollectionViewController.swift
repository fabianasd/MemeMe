//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Gabriel Petrovick on 20/03/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var MemeTableView: UITableView!
    
    var allMeme = [Meme]()
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillApper MEME COLE")
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
        allMeme = appDelegate.memes
        MemeTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad MEME COLE")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewDidAppear MEME COLE")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Aqui no meme collection numberOfRowsInSection")
        return self.allMeme.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Aqui no meme collection cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCollectionViewCell") as! MemeCollectionViewCell
        let meme = self.allMeme[(indexPath as NSIndexPath).row]
        // Set the name and image
        cell.nameLabel.text = meme.top.description
        cell.MemeImageView?.image = meme.originalImage

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("Aqui no meme collection didSelectRowAt")
        // let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeCollectionViewCell") as! ViewController
        // detailController.memedImage = self.allMeme[(indexPath as NSIndexPath).row].memedImage
        // self.navigationController!.pushViewController(detailController, animated: true)
    }
}
