//
//  MemeCollectionViewController.swift
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillApper List")
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        
        allMeme = appDelegate.memes
        MemeTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad list")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewDidAppear List")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Aqui no List numberOfRowsInSection")
        return self.allMeme.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Aqui no List cellForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCollectionViewCell") as! MemeCollectionViewCell
        let meme = self.allMeme[(indexPath as NSIndexPath).row]
        // Set the name and image
        //cell.MemeImageView?.image = meme.originalImage
        cell.MemeImageView = meme.memedImage
        cell.topLabel.text = meme.top.description
        cell.BottomLabel.text = meme.bottom.description
        
        tableView.rowHeight = 96
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("Aqui no meme collection didSelectRowAt")
        // let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeCollectionViewCell") as! ViewController
        // detailController.memedImage = self.allMeme[(indexPath as NSIndexPath).row].memedImage
        // self.navigationController!.pushViewController(detailController, animated: true)
    }
}
