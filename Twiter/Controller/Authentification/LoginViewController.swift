//
//  LoginViewController.swift
//  Twiter
//
//  Created by aymen braham on 04/02/2021.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "TwitterLogo")
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Email", isSecure: false)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Password", isSecure: true)
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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 20)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    private let signUpButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    

    // MARK: - UserInteraction
    @objc
    func loginAction() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        AuthService.shared.userLogIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG error \(error.localizedDescription)")
                return
            }
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) else { return }
            guard let tab = window.rootViewController as? MainTabController else { return }
            tab.checkUserSignIn()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    func signUpAction() {
      let registreController = RegistreController()
        navigationController?.pushViewController(registreController, animated: true)
    }
    
    
    // MARK: SetUp UI
    
    func configUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        view.addSubview(signUpButton)
        signUpButton.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
        
    }
    

}
