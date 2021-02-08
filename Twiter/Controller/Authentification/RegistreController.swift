//
//  RegistreController.swift
//  Twiter
//
//  Created by aymen braham on 04/02/2021.
//

import UIKit

class RegistreController: UIViewController {

    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    
    private let addPhotoButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(addImageAction), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Email", isSecure: false)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Password", isSecure: true)
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Full Name", isSecure: false)
        return tf
    }()
    
    private let userNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "User Name", isSecure: true)
        return tf
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_mail_outline_white_2x-1"), textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField)
        return view
    }()
    
    private lazy var userNameContainerView: UIView = {
        let view = Utilities().inputContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: userNameTextField)
        return view
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return button
    }()
    private let signInButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account? ", "Sign In")
        button.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    
    // MARK: - UserInteraction
    @objc
    func signUpAction() {
      print("signUpAction")
    }
    
    
    @objc
    func addImageAction() {
      present(imagePicker, animated: true, completion: nil)
    }
    
    @objc
    func signInAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: SetUp UI
    
    func configUI() {
        view.backgroundColor = .twitterBlue
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        addPhotoButton.setDimensions(width: 128, height: 128)
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, userNameContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: addPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,  paddingTop: 32 , paddingLeft: 16, paddingRight: 16)
        view.addSubview(signInButton)
        signInButton.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }

}


extension RegistreController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profilImage = info[.editedImage] as? UIImage else { return }
        
        self.addPhotoButton.layer.cornerRadius = 128 / 2
        self.addPhotoButton.layer.masksToBounds = true
        self.addPhotoButton.imageView?.contentMode = .scaleAspectFill
        self.addPhotoButton.imageView?.clipsToBounds = true
        self.addPhotoButton.layer.borderWidth = 3
        self.addPhotoButton.layer.borderColor = UIColor.white.cgColor
        self.addPhotoButton.setImage(profilImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        dismiss(animated: true, completion: nil)
    }
}
