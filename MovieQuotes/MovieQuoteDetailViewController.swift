//
//  MovieQuoteDetailViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 5/7/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit

class MovieQuoteDetailViewController: UIViewController {

    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    
    var movieQuote: MovieQuite?
    
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
            self.movieQuote?.quote = quoteTextFields.text!
            self.movieQuote?.movie = movieTextFields.text!
            self.updateView()
        })
            alertController.addAction(submitAction)
        
            present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    func updateView() {
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }
}
