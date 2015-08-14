//
//  MasterViewModel.swift
//  BooksAndMovies
//
//  Created by Josh Brown on 8/14/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import Foundation

class MasterViewModel {
    
    var entries = [[String: AnyObject]]()
    let client = ITunesClient()
        
    func refreshMovies(didRefreshMovies: () -> ()) {
        client.loadMovies { [unowned self] (entries) -> () in
            if let entries = entries {
                self.entries = entries
            }
            didRefreshMovies()
        }
    }
    
    func refreshBooks(didRefreshBooks: () -> ()) {
        client.loadBooks { [unowned self] (entries) -> () in
            if let entries = entries {
                self.entries = entries
            }
            didRefreshBooks()
        }
    }
    
    func numberOfItems() -> Int {
        return entries.count
    }
    
    func titleForItemAtIndexPath(indexPath: NSIndexPath) -> String {
        let entry = entries[indexPath.row]
        if let name = entry["im:name"] as? [String: AnyObject],
            let label = name["label"] as? String {
                return label
        }
        return ""
    }
    
    func detailViewModelForIndexPath(indexPath: NSIndexPath) -> DetailViewModel {
        let entry = entries[indexPath.row]
        return DetailViewModel(entry: entry)
    }
}




