//
//  ExploreController.swift
//  Twiter
//
//  Created by aymen braham on 04/02/2021.
//

import Foundation
import UIKit

class ExploreController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }

}
