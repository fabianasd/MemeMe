//
//  favoriteThings.swift
//  MemeMe
//
//  Created by Fabiana Petrovick on 02/03/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

class favoriteThings: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteThings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteThingCell", for: indexPath) as! UITableViewCell
        cell.textLabel?.text = favoriteThings[indexPath.row]
        return cell
    }
    
    
    let favoriteThings = [
    "Linha 1",
    "Linha 2",
    "Linha 3",
    "Linha 4",
    "Linha 5"
    ]
}
