//
//  Constant.swift
//  Twiter
//
//  Created by aymen braham on 11/02/2021.
//

import Firebase

let REF_STORAGE = Storage.storage().reference()
let REF_STORAGE_IMAGES = REF_STORAGE.child("profile_images")

let REF_Database = Database.database().reference()
let REF_USER = REF_Database.child("users")
let REF_TWEET = REF_Database.child("tweets")
