//
//  MovieQuote.swift
//  MovieQuotes
//
//  Created by CSSE Department on 5/6/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import Foundation
import Firebase

class MovieQuite {
    var quote: String
    var movie: String
    var id: String?
    
    
    init(quote: String, movie: String) {
        self.quote = quote
        self.movie = movie
    }
    
    init(documentSnapShot: DocumentSnapshot) {
        self.id = documentSnapShot.documentID
        let data = documentSnapShot.data()!
        self.quote = data["quote"] as! String
        self.movie = data["movie"] as! String
    }
}
