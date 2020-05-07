//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 5/6/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class MovieQuotesTableViewController: UITableViewController {
    var names = ["Jordan", "Don", "Toni", "Rylee", "Tosha"]
    let movieQuoteCellID = "MovieQuoteCell"
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieQuoteCellID, for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        
        return cell
    }
}
