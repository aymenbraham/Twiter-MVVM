//
//  Tweet.swift
//  Twiter
//
//  Created by aymen braham on 14/02/2021.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    var timeStamp: Date!
    let retweetCount: Int
    
    
    init(tweetId: String, dictionary: [String: Any]) {
        self.tweetID = tweetId
        self.caption = dictionary["caption"] as? String ??  ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        if let timestamp = dictionary["timeStamp"] as? Double {
            self.timeStamp = Date(timeIntervalSince1970: timestamp)
        }
        self.retweetCount = dictionary["retweetCount"] as? Int ?? 0
    }
}
