//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 27/03/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memeImage!.image = meme.memedImage.image
    }
}
