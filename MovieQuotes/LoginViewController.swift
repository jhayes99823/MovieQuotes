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
import Rosefire
import GoogleSignIn

class LoginViewController: UIViewController {
    var showListSegueID = "ShowListSegue"
    
    let REGISTRY_TOKEN = "43467d99-c46d-4f7e-93c8-f79439dadd82"

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
        GIDSignIn.sharedInstance()?.presentingViewController = self
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
    
    @IBAction func pressedRoseFireLogin(_ sender: Any) {
        Rosefire.sharedDelegate().uiDelegate = self // This should be your view controller
        Rosefire.sharedDelegate().signIn(registryToken: REGISTRY_TOKEN) { (err, result) in
          if let err = err {
            print("Rosefire sign in error! \(err)")
            return
          }
//          print("Result = \(result!.token!)")
          print("Result = \(result!.username!)")
          print("Result = \(result!.name!)")
          print("Result = \(result!.email!)")
          print("Result = \(result!.group!)")
          Auth.auth().signIn(withCustomToken: result!.token) { (authResult, error) in
            if let error = error {
              print("Firebase sign in error! \(error)")
              return
            }
            // User is signed in using Firebase!
            self.performSegue(withIdentifier: self.showListSegueID, sender: self)
          }
        }

    }
}
