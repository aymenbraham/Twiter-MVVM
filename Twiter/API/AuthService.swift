//
//  AuthService.swift
//  Twiter
//
//  Created by aymen braham on 11/02/2021.
//

import Foundation
import UIKit
import Firebase


struct AuthCredentials {
    let email: String
    let password: String
    let userName: String
    let fullName: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    
    func userLogIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        let email = credentials.email
        let password = credentials.password
        let userName = credentials.userName
        let fullName = credentials.fullName

        
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {
            return
        }
        let fileName = NSUUID().uuidString
        
        let storageREF = REF_STORAGE_IMAGES.child(fileName)
        
        storageREF.putData(imageData, metadata: nil) { (meta, error) in
            storageREF.downloadURL { (url, error) in
                guard let urlImage = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: email, password: password, completion:  { (result, error) in
                    if let error = error {
                        print("DEBUG: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    let value = ["email": email,
                                 "userName": userName,
                                 "fullName": fullName,
                                 "profileImageUrl": urlImage]
                    REF_USER.child(uid).updateChildValues(value, withCompletionBlock: completion)
                })
            }
        }
    }
}
