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
        
//        lbUsernameOutlet.text = DatabaseManager.shared.insertUser(with: ChatAppUser).self
        
        // Do any additional setup after loading the view.
        title = "Profile"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(didTapLogin))
    }
    

    @IBAction func logoutBtnAction(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
                actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler:{ [weak self] _ in
                    guard let strongSelf = self else {
                        return
                    }
              
                    do {
                                try FirebaseAuth.Auth.auth().signOut()
                        let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
                                let nav = UINavigationController(rootViewController: vc)
                                nav.modalPresentationStyle = .fullScreen
                     
                    strongSelf.present(nav, animated: true)
                        
                            } catch {
                                print("Error Log Out User: \(error.localizedDescription)")
                            }
                }))
                
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(actionSheet , animated: true)

        
    }
    // MARK: Functions Section


}
