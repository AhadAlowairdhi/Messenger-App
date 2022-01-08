//
//  ConversationsTVC.swift
//  Messenger App
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsTVC: UITableViewController {

    private let spinner = JGProgressHUD(style: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))

        //        do{
//            try Auth.auth().signOut()
//        }catch{
//            print(error.localizedDescription)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            validateAuth()
        }

//MARK: Functions Section
    private func validateAuth(){
        if Auth.auth().currentUser == nil {
        //  let vc = LogInVC()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: false)
                   }
               }
    
    @objc private func didTapComposeButton(){
            let vc = NewConversationVC()
            let navVc = UINavigationController(rootViewController: vc)
            present(navVc , animated: true)
            
        }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "conversatinsCell", for: indexPath)
            cell.textLabel?.text="Hello World"
        cell.accessoryType = .disclosureIndicator
            return cell
        }
        
         override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath , animated: true)
             let vc = ChatVC()
             vc.navigationItem.largeTitleDisplayMode = .never
             navigationController?.pushViewController(vc, animated: true)
             
        }


}
