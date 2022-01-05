//
//  ConversationsTVC.swift
//  Messenger App
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth

class ConversationsTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try Auth.auth().signOut()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            validateAuth()
        }

    //MARK: Functions
    private func validateAuth(){
        if Auth.auth().currentUser == nil {
        //  let vc = LogInVC()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: false)
                   }
               }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
