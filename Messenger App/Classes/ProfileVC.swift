//
//  ProfileVC.swift
//  Messenger App
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth
import SDWebImage

class ProfileVC: UIViewController {
    
    @IBOutlet weak var imgVProfile: UIImageView!
    
    @IBOutlet weak var lbUsernameOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgVProfile.layer.borderColor = UIColor.white.cgColor
        imgVProfile.layer.borderWidth = 3
        imgVProfile.layer.masksToBounds = true
        imgVProfile.layer.cornerRadius = imgVProfile.frame.size.width/2
        
        
        
        // Do any additional setup after loading the view.
        title = "Profile"
        
        
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(didTapLogin))
    }
    override func viewDidAppear(_ animated: Bool) {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        guard let username = UserDefaults.standard.value(forKey: "name") as? String else {
            return
        }
        lbUsernameOutlet.text = username
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let filename = safeEmail + "_profile_picture.png"
        let path = "image/"+filename
        StorageManager.shared.downloadURL(for: path, completion: { result in
            switch result {
            case .success(let url):
                self.imgVProfile.sd_setImage(with: url, completed: nil)
            case .failure(let error):
                print("Download Url Failed: \(error)")
            }
        })
        
    }
    
    
    @IBAction func logoutBtnAction(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "", message: "Are you sure?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler:{ [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            
            UserDefaults.standard.setValue(nil, forKey: "email")
            UserDefaults.standard.setValue(nil, forKey: "name")
            
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
