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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddQuoteDialog))
    }
    
   @objc func showAddQuoteDialog() {
        let alertController = UIAlertController(title: "Create a new movie quote", message: "", preferredStyle: .alert)
    
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Quote"
        }
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Movie"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
    
    let submitAction = UIAlertAction(title: "Create Quote", style: .default, handler: { (action) in let quoteTextFields = alertController.textFields![0] as UITextField
        let movieTextFields = alertController.textFields![1] as UITextField
        let newMoview = MovieQuite(quote: quoteTextFields.text!, movie: movieTextFields.text!)
        self.movieQuotes.insert(newMoview, at: 0)
        self.tableView.reloadData()
        
    })
        alertController.addAction(submitAction)
    
        present(alertController, animated: true, completion: nil)
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
