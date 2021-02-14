//
//  TweetService.swift
//  Twiter
//
//  Created by aymen braham on 14/02/2021.
//

import Foundation
import Firebase

struct TweetService {
    static let shared = TweetService()
    
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void ) {
       
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timeStamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweetCount": 0,
                      "caption": caption] as [String : Any]
        
        REF_TWEET.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweet(completion: @escaping([Tweet]) -> Void) {
        
        var tweets = [Tweet]()
        
        REF_TWEET.observe(.childAdded) { snap in
            guard let dictionary = snap.value as? [String: Any] else { return }
            let tweetID = snap.key
            
            let tweet = Tweet(tweetId: tweetID, dictionary: dictionary)
            
            tweets.append(tweet)
            completion(tweets)
        }
        
    }
}
