//
//  RegisterVC.swift
//  Messenger App
//
//  Created by administrator on 04/01/2022.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEAddress: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Create Account"
        view.backgroundColor = .white
    }

    @IBAction func registerBtnAction(_ sender: UIButton) {
        
        guard let fName = tfFirstName.text, let lName = tfLastName.text, let eAddress = tfEAddress.text , let nPass = tfNewPassword.text, !fName.isEmpty, !lName.isEmpty , !eAddress.isEmpty, !nPass.isEmpty else {
                    alertEmpty()
                    return
                }
    }
    
    // MARK: Alert Action
    func alertEmpty(){
        let alert = UIAlertController(title: "Error", message: "Text Fields must be not empty", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(alert, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
