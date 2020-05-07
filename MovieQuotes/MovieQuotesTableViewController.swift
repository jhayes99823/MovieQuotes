//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 5/6/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class MovieQuotesTableViewController: UITableViewController {
    let movieQuoteCellID = "MovieQuoteCell"
    var movieQuotes = [MovieQuite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieQuotes.append(MovieQuite(quote: "I'll be back", movie: "Terminator"))
        movieQuotes.append(MovieQuite(quote: "Yo Adrian!", movie: "Rocky"))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieQuoteCellID, for: indexPath)
        
        // config cell
        cell.textLabel?.text = movieQuotes[indexPath.row].quote
        cell.detailTextLabel?.text = movieQuotes[indexPath.row].movie
        
        return cell
    }
}
