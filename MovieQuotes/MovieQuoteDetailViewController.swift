//
//  MovieQuoteDetailViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 5/7/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import Firebase

class MovieQuoteDetailViewController: UIViewController {

    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    
    var movieQuote: MovieQuite?
    
    var movieQuoteRef: DocumentReference!
    var movieQuoteListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showEditDialog))
    }
    
    @objc func showEditDialog() {
        let alertController = UIAlertController(title: "Edit movie quote", message: "", preferredStyle: .alert)
        
            alertController.addTextField { (textfield) in
                textfield.placeholder = "Quote"
                textfield.text = self.movieQuote?.quote
            }
            
            alertController.addTextField { (textfield) in
                textfield.placeholder = "Movie"
                textfield.text = self.movieQuote?.movie
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        
        let submitAction = UIAlertAction(title: "Edit Quote", style: .default, handler: { (action) in let quoteTextFields = alertController.textFields![0] as UITextField
            let movieTextFields = alertController.textFields![1] as UITextField
//            self.movieQuote?.quote = quoteTextFields.text!
//            self.movieQuote?.movie = movieTextFields.text!
//            self.updateView()
            self.movieQuoteRef.updateData([
                "quote": quoteTextFields.text!,
                "movie": movieTextFields.text!
            ])
        })
            alertController.addAction(submitAction)
        
            present(alertController, animated: true, completion: nil)
    }
    
     override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            movieQuoteListener = movieQuoteRef.addSnapshotListener { (documentSnapshot, error) in
                if let error = error {
                    print("Error getting movie quote \(error)")
                    return
                }
                if !documentSnapshot!.exists {
                    print("Might go back to the list since someone else deleted this document")
                    return
                }
                self.movieQuote = MovieQuite(documentSnapShot: documentSnapshot!)
                self.updateView()
            }
        }
    
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            movieQuoteListener.remove()
        }
    
    func updateView() {
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }
}
