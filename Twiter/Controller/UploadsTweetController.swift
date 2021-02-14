//
//  UploadsTweetController.swift
//  Twiter
//
//  Created by aymen braham on 14/02/2021.
//

import UIKit

class UploadsTweetController: UIViewController {
    
    // MARK: - Properties
    private let user: User
    
    private lazy var tweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .twitterBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32 / 2
        
        button.addTarget(self, action: #selector(tweetAction), for: .touchUpInside)
        return button
    }()
    
    
    private let profileImageview: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        
        return iv
    }()
    
    private let captionTextView = CaptionTextView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        configUI()
        
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UserInteraction
    @objc
    func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func tweetAction() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption) { (error, ref) in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - API
    
    
    // MARK: - Helpers
    
    func configUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [profileImageview, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight:  16)
        guard let url = URL(string: user.imageUrl) else { return }
        profileImageview.sd_setImage(with: url, completed: nil)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
       navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
    
}
