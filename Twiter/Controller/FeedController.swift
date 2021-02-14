//
//  FeedController.swift
//  Twiter
//
//  Created by aymen braham on 04/02/2021.
//

import Foundation
import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"

class FeedViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var tweets = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
        fetchTweets()
    }
    
    
    // MARK: -API
    
    func fetchTweets() {
        TweetService.shared.fetchTweet { tweet in
            print("DEBUG: Tweet \(tweet)")
            self.tweets = tweet
        }
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView
            
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

extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}


