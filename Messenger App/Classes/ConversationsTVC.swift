//
//  ConversationsTVC.swift
//  Messenger App
//
//  Created by administrator on 04/01/2022.
//

import UIKit

class ConversationsTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
            
            if !isLoggedIn {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
                // let vs = ChatVS()
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
