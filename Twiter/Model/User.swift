//
//  User.swift
//  Twiter
//
//  Created by aymen braham on 12/02/2021.
//

import Foundation


struct User {
    
    let fullName: String
    let userName: String
    let email: String
    let imageUrl: String
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.userName = dictionary["username"] as? String ??  ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.imageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
