//
//  UserService.swift
//  Twiter
//
//  Created by aymen braham on 12/02/2021.
//

import Foundation
import Firebase

struct UserService {
    
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USER.child(uid).observeSingleEvent(of: .value) { (snapshot) in
        guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
        
        let user = User(uid: uid, dictionary: dictionary)
         completion(user)
        }
    }
    
}
