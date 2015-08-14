//
//  DetailViewModel.swift
//  BooksAndMovies
//
//  Created by Josh Brown on 8/14/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Foundation

class DetailViewModel {
    private var entry: [String: AnyObject]
    
    init(entry: [String: AnyObject]) {
        self.entry = entry
    }
    
    func fetchImage(completion: (data: NSData?) -> ()) {
        if let images = entry["im:image"] as? [[String: AnyObject]],
            let image = images.last,
            let label = image["label"] as? String {
                let url = NSURL(string: label)!
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                    completion(data: data)
                    return
                })
                task.resume()
        } else {
            completion(data: nil)
        }
    }
    
    func title() -> String {
        if let name = entry["im:name"] as? [String: AnyObject],
            let label = name["label"] as? String {
                return label
        }
        return ""
    }
    
    func artist() -> String {
        if let artist = entry["im:artist"] as? [String: AnyObject],
            let label = artist["label"] as? String {
                return label
        }
        return ""
    }
    
    func genre() -> String {
        if let category = entry["category"] as? [String: AnyObject],
            let attributes = category["attributes"] as? [String: AnyObject],
            let label = attributes["label"] as? String {
                return label
        }
        return ""
    }
    
    func summary() -> String {
        if let summary = entry["summary"] as? [String: AnyObject],
            let label = summary["label"] as? String {
                return label
        }
        return ""
    }
}