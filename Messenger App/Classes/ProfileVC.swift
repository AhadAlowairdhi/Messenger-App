//
//  ProfileVC.swift
//  Messenger App
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet weak var lbUsernameOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(didTapLogin))
    }
    

    @IBAction func logoutBtnAction(_ sender: UIButton) {
       
        
        
    }
    
    // MARK: Functions Section
    @objc private func didTapLogin() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
                self.navigationController?.pushViewController(vc, animated: false)

    }

}
