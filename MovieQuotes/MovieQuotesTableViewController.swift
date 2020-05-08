//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 5/6/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class MovieQuotesTableViewController: UITableViewController {
    let movieQuoteCellID = "MovieQuoteCell"
    let detailSegueID = "DetailSegue"
    
    var movieQuotesRef: CollectionReference!
    var movieQuoteListener: ListenerRegistration!
    
    var movieQuotes = [MovieQuite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        movieQuotes.append(MovieQuite(quote: "I'll be back", movie: "Terminator"))
        movieQuotes.append(MovieQuite(quote: "Yo Adrian!", movie: "Rocky"))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddQuoteDialog))
        
        movieQuotesRef = Firestore.firestore().collection("MovieQuotes")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        movieQuoteListener = movieQuotesRef.order(by: "created", descending: true).limit(to: 50).addSnapshotListener {
            (querySnapShot, error) in if let querySnapShot = querySnapShot {
                self.movieQuotes.removeAll()
                querySnapShot.documents.forEach { (docSnapShot) in
                    self.movieQuotes.append(MovieQuite(documentSnapShot: docSnapShot))
                }
                self.tableView.reloadData()
            }
            else {
                print("Error getting movie quotes \(error!)")
                return
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieQuoteListener.remove()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let movieQuoteToDelete = movieQuotes[indexPath.row]
            movieQuotesRef.document(movieQuoteToDelete.id!).delete()
        }
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
//        let newMoview = MovieQuite(quote: quoteTextFields.text!, movie: movieTextFields.text!)
//        self.movieQuotes.insert(newMoview, at: 0    )
        self.movieQuotesRef.addDocument(data: [
            "quote": quoteTextFields.text!,
            "movie": movieTextFields.text!,
            "created": Timestamp.init()
        ])
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueID {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as! MovieQuoteDetailViewController).movieQuote = movieQuotes[indexPath.row]
            }
        }
    }
}
