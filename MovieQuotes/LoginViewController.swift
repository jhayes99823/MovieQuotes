//
//  LoginViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 5/11/20.
//  Copyright © 2020 CSSE Department. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    var showListSegueID = "ShowListSegue"

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil{
            print("someone signed in already")
            self.performSegue(withIdentifier: self.showListSegueID, sender: self)
        }
    }
    
    @IBAction func pressedSignInNewUser(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (authRes, error) in
            if let error = error {
                print ("error creatign a new user for email/password \(error)")
                return
            }
            
            print("new user created and now signed in")
            self.performSegue(withIdentifier: self.showListSegueID, sender: self)
        }
    }
  
    @IBAction func pressedLoginExistingUser(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { (authRes, error) in
            if let error = error {
                print ("error creatign a new user for email/password \(error)")
                return
            }
            
            print("signed in existing user")
            self.performSegue(withIdentifier: self.showListSegueID, sender: self)
        }
    }
    
}
