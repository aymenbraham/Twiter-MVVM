//
//  FeedController.swift
//  Twiter
//
//  Created by aymen braham on 04/02/2021.
//

import Foundation
import UIKit
import SDWebImage

class FeedViewController: UIViewController {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            print("DEBUG: user set in Feed Controller")
            configurePorfileImage()
        }
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    
    // MARK: - Helpers
    
    func configureUI() {
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        view.backgroundColor = .white
            
    }
    
    func configurePorfileImage() {
        guard let user = user else { return }
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        
        guard let imageUlr = URL(string: user.imageUrl) else { return }
        profileImageView.sd_setImage(with: imageUlr, completed: nil)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }

}


