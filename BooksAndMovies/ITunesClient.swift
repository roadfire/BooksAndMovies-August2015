//
//  ITunesClient.swift
//  BooksAndMovies
//
//  Created by Josh Brown on 8/14/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Foundation

class ITunesClient {
    private let moviesURL = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
    private let booksURL = "https://itunes.apple.com/us/rss/topebooks/limit=25/json"
    
    // entries should be an array of MediaItem: `[MediaItem]`
    func loadMovies(completion: (entries: [[String: AnyObject]]?) -> ()) {
        loadFromURL(moviesURL, completion: completion)
    }
    
    func loadBooks(completion: (entries: [[String: AnyObject]]?) -> ()) {
        loadFromURL(booksURL, completion: completion)
    }
    
    private func loadFromURL(urlString: String, completion: (entries: [[String: AnyObject]]?) -> ()) {
        let url = NSURL(string: urlString)!
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: { [unowned self] (data, response, error) -> Void in
            println("got a response")
            
            if let error = error {
                print("error: \(error)")
                return
            }
            
            var jsonError: NSError?
            
            if let json = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &jsonError) as? [String: AnyObject] {
                println("json: \(json)")
                
                if let feed = json["feed"] as? [String: AnyObject],
                    let jsonEntries = feed["entry"] as? [[String: AnyObject]] {
                        completion(entries: jsonEntries)
                        return
                }
            }
            
            completion(entries: nil)
            })
        task.resume()
    }
}