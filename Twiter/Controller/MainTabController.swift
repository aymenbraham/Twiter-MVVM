//
//  MainTabController.swift
//  Twiter
//
//  Created by aymen braham on 04/02/2021.
//

import UIKit
import Firebase



class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var user: User? {
        didSet {
            guard let nav =  viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedViewController else {
                return
            }
            feed.user = user
        }
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        checkUserSignIn()
       // logOutUser()
    }
    
    // MARK: - UserInteractions
    @objc
    func actionButtonTapped() {
        guard let user = user else { return }
        let nav = UINavigationController(rootViewController: UploadsTweetController(user: user))
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - API
    
    func fetchUser()  {
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }
    
    func checkUserSignIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            print("DEBUG user Sign In")
            configUI()
            configViewController()
            fetchUser()
        }
    }
    
    func logOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG ERROR: \(error.localizedDescription)")
        }
    }
    // MARK: - Helpers
    
    func configUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
        
    }
    
    func configViewController() {
        let feed = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        
        let notification = NotificationController()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notification)

        let conversation = ConversationController()
        let nav4 = templateNavigationController(image: UIImage(named: "mail"), rootViewController: conversation)
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.navigationBar.barTintColor = .white
        nav.tabBarItem.image = image
        return nav
    }

}


