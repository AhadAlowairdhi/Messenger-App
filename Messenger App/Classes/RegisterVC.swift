//
//  RegisterVC.swift
//  Messenger App
//
//  Created by administrator on 04/01/2022.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class RegisterVC: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEAddress: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imgView.layer.cornerRadius = imgView.frame.size.width/2
        title = "Create Account"
        view.backgroundColor = .white
        imgView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.presentPhotoActionSheet))
        imgView.addGestureRecognizer(gesture)
    }
    
    // MARK: Button Action
    @IBAction func registerBtnAction(_ sender: UIButton) {
        guard let fName = tfFirstName.text, let lName = tfLastName.text, let eAddress = tfEAddress.text , let nPass = tfNewPassword.text, !fName.isEmpty, !lName.isEmpty , !eAddress.isEmpty, !nPass.isEmpty else {
            alertEmpty()
            return
        }
        
        // Firebase Login
        DatabaseManager.shared.userExists(with: eAddress, completion: { [weak self] exists in
            guard let strongSelf = self else{
                return
            }
            
            guard !exists else{
                // user already exists
                strongSelf.alertEmpty(message: "Account already exists")
                return
            }
            Auth.auth().createUser(withEmail: eAddress, password: nPass, completion: { authResult, error in
                
                guard authResult != nil, error == nil else{
                    print("Error Creating User")
                    return
                }
                UserDefaults.standard.setValue(eAddress, forKey: "email")
                UserDefaults.standard.setValue("\(fName) \(lName)", forKey: "name")
                
                let chatUser = ChatAppUser(firstName: fName, lastName: lName, emailAddress: eAddress)
                DatabaseManager.shared.insertUser(with: chatUser,completion: { success in
                    if success {
                        //upload image
                        guard let image = strongSelf.imgView.image,
                              let data = image.pngData() else {
                                  return
                              }
                        let fileName = chatUser.profilePictureFileName
                        StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName, completion: { result in
                            switch result{
                            case.success(let downloadUrl):
                                UserDefaults.standard.setValue(downloadUrl, forKey: "profile_picture_url")
                                print(downloadUrl)
                            case.failure(let error):
                                print("Storage manger error\(error)")
                            }
                            
                        })
                        
                    }
                })
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    
    // MARK: Alert Action
    func alertEmpty(message: String = "Text Fields must be not empty"){
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    } //End of alert action
    
    
} // End of class
// MARK: Extension Section
extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // get results of user taking picture or selecting from camera roll
    
    @objc func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
    }
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // take a photo or select a photo
        
        // action sheet - take photo or choose photo
        picker.dismiss(animated: true, completion: nil)
        print(info)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        self.imgView.image = selectedImage
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

