//
//  LoginViewController.swift
//  Instagram-01
//
//  Created by Anish Adhikari on 2/20/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var isBothTextFieldEditing: Bool = false
    var loginButtonsHighlighted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameField.borderStyle = UITextBorderStyle.roundedRect
        passwordField.borderStyle = UITextBorderStyle.roundedRect
        
        signInButton.layer.borderWidth = 0.5
        signInButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5).cgColor
        
        signUpButton.layer.borderWidth = 0.5
        signUpButton.layer.borderColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1).cgColor
        
        userNameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        passwordField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // Do any additional setup after loading the view.
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if userNameField.text != "" && passwordField.text != "" {
            isBothTextFieldEditing = true
        } else {
            isBothTextFieldEditing = false
        }
        
        if isBothTextFieldEditing && !loginButtonsHighlighted {
                signInButton.layer.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 0.9).cgColor
            signInButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            loginButtonsHighlighted = true
        }
        
        if !isBothTextFieldEditing && loginButtonsHighlighted {
            signInButton.layer.backgroundColor = nil
            signInButton.setTitleColor(UIColor(red: 0, green: 0.5, blue: 1, alpha: 0.9), for: .normal)
            loginButtonsHighlighted = false
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        self.activityIndicator.startAnimating()
        let username = userNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        PFUser.logInWithUsername(inBackground: username!, password: password!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print("User succesfully logged in")
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        self.activityIndicator.startAnimating()
        let newUser = PFUser()
        newUser.username = userNameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success == true {
                print("User successfully registered.")
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
            self.activityIndicator.stopAnimating()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
