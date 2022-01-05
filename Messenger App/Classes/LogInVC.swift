//
//  ViewController.swift
//  Messenger App
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth

class LogInVC: UIViewController {

    // MARK: Outlet
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Log In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
    }


    @IBAction func loginBtnAction(_ sender: UIButton) {
        guard let email = tfEmail.text, let password = tfPassword.text, !email.isEmpty, !password.isEmpty else {
                    alertLogInError()
                    return
                }
        guard let pass = tfPassword.text, pass.count >= 6  else {
            alretPassword()
            return
        }
        
        // Firebase Login
        Auth.auth().signIn(withEmail: email, password: password, completion: { authResult, error in
            guard let result = authResult, error == nil else{
                print("Failed to log in user with email \(email)")
                return
            }
            let user = result.user
            print("Logged In User: \(user)")
        })
    }
    
    @IBAction func facebookBtnAction(_ sender: UIButton) {
        
    }
    // MARK: Alerts action
    
    // check empty
    func alertLogInError() {
        let alert = UIAlertController(title: "Error", message: "Text Fields must be not empty", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alert, animated: true)
    }
    
    // check password
    func alretPassword(){
        let alert = UIAlertController(title: "Error", message: "Password must be more than 6 character", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alert, animated: true)
    }
    
    // MARK: Functions Section
    @objc private func didTapRegister() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
                self.navigationController?.pushViewController(vc, animated: false)

    }
    
}

