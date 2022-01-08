//
//  NewConversationVC.swift
//  Messenger App
//
//  Created by administrator on 08/01/2022.
//

import UIKit
import JGProgressHUD

class NewConversationVC: UIViewController {
     
//  MARK: UI Elements
        private let spinner = JGProgressHUD()
        
        private let SearchBar : UISearchBar = {
          
            let searchBar = UISearchBar()
            searchBar.placeholder="Search for users.."
            return searchBar
        }()
    
    // TableView
        private let tabelView: UITableView = {
        
            let tabel = UITableView()
            tabel.isHidden = true
            tabel.register(UITableViewCell.self , forCellReuseIdentifier: "cellUser")
    
            return tabel
            
        }()
        // label
        private let noResultLabel : UILabel = {
          let label = UILabel()
            label.isHidden = true
            label.text = "No Results"
            label.textAlignment = .center
            label.textColor = .blue
            label.font = .systemFont(ofSize: 20,weight: .regular)
            
            return label
        }()
 
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // search bar
        view.backgroundColor = .white
                SearchBar.delegate = self
                navigationController?.navigationBar.topItem?.titleView = SearchBar
        // canceled for search bar
                navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(tapedCancel))
               
                SearchBar.becomeFirstResponder()
    }
    
    @objc func tapedCancel(){
           dismiss(animated: true,completion: nil)
       }

}
// MARK: Extensions
extension NewConversationVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}
